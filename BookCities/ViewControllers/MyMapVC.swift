//
//  MyMapVC.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/10/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import MapKit
import PKHUD
class MyMapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager!
    var geocoder:CLGeocoder!
    var placemark:CLPlacemark!
    var mapAnnotations: [MKAnnotation] = []
    var tit:String?
    var currentLocation:MKUserLocation?
    var city:JSONCity?
    var stores:[JSONStore]?
    var totalStores:[JSONStore]?
    @IBOutlet weak var newBookBtn: BorderButton!
    @IBOutlet weak var usedBookBtn: BorderButton!
    @IBOutlet weak var museumShopsBtn: BorderButton!
    @IBOutlet weak var resetFilterBtn: UIButton!
    @IBOutlet weak var heightOfResetC: NSLayoutConstraint!
    @IBOutlet weak var blackBoarderV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar Update
        self.navigationItem.title = tit
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        if (self.navigationController?.viewControllers.count) != 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        }
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        totalStores = stores
        self.mapView.delegate = self
        
        // Intialize the LocationManager
        locationManager = CLLocationManager()
        
        // Gets user permission use location while the app is in the foreground.
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // intialize GeoCoder object
        self.geocoder = CLGeocoder()
        // create out annotations array (in this example only 3)
        self.addAnnotationToMap()
        self.mapView.showsUserLocation = true
        self.mapView.showsPointsOfInterest = false
        if let currentCity = city {
             self.gotoDefaultLocation(currentCity)
        }
        else{
            if (self.navigationController?.viewControllers.count)! > 1 {
                if self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-2] is ShopDetailVC {
                    goToStoreLocation(store: (self.stores?[0])!,span: 0.009)
                }
            }
        }
        
        setView()
        if (self.navigationController?.viewControllers.count)! > 1 && (self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-2] is ShopDetailVC)
        {
            newBookBtn.isHidden = true
            usedBookBtn.isHidden = true
            museumShopsBtn.isHidden = true
            blackBoarderV.isHidden = true
        }
    }
    
    func setView(){
        newBookBtn.isSelected = true
        usedBookBtn.isSelected = true
        museumShopsBtn.isSelected = true
        self.newBookBtn.isSelected = true
        self.usedBookBtn.isSelected = true
        self.museumShopsBtn.isSelected = true
        self.newBookBtn.addBorder(width: 1)
        self.usedBookBtn.addBorder(width: 1)
        self.museumShopsBtn.addBorder(width: 1)
    
        navigationController!.navigationBar.isTranslucent = false
        
        // The navigation bar's shadowImage is set to a transparent image.  In
        // addition to providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        navigationController!.navigationBar.shadowImage = #imageLiteral(resourceName: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Pixel"), for: .default)
        navigationItem.prompt = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
    
    func goBack(_ sender:AnyObject) -> ()
    {
        self.navigationController!.popViewController(animated: true)
    }
    func closeBtnAction(_ sender:AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func newBookBtnAction(_ sender: Any) {
        self.usedBookBtn.isSelected = false
        self.museumShopsBtn.isSelected = false
        self.newBookBtn.isSelected = true
        if self.heightOfResetC.constant == 0 {
            showFilterView(true)
        }
        var storesData:Array<JSONStore> = Array()
        for store in totalStores!{
            if store.is_new_books == "1"{
                storesData.append(store)
            }
        }
        stores = storesData
        self.addAnnotationToMap()
    }
    
    @IBAction func usedBookBtnAction(_ sender: Any) {
        self.museumShopsBtn.isSelected = false
        self.newBookBtn.isSelected = false
        self.usedBookBtn.isSelected = true
        if self.heightOfResetC.constant == 0 {
            showFilterView(true)
        }
        var storesData:Array<JSONStore> = Array()
        for store in totalStores!{
            if store.is_used_books == "1"{
                storesData.append(store)
            }
        }
        stores = storesData
        self.addAnnotationToMap()
    }
    
    @IBAction func museumShopsBtnAction(_ sender: Any) {
        self.newBookBtn.isSelected = false
        self.usedBookBtn.isSelected = false
        self.museumShopsBtn.isSelected = true
        if self.heightOfResetC.constant == 0 {
            showFilterView(true)
        }
        var storesData:Array<JSONStore> = Array()
        for store in totalStores!{
            if store.is_museumshops == "1"{
                storesData.append(store)
            }
        }
        stores = storesData
        self.addAnnotationToMap()
    }
    
    @IBAction func resetFilterBtnAction(_ sender: Any) {
        defaultViewSetting()
        showFilterView(false)
        stores = totalStores
        self.addAnnotationToMap()
    }
    
    @objc func buttonAction(_ button: UIButton) {
        for store in stores! {
            if Int(store.id!)! == button.tag
            {
                BookCitiesClient.sharedInstance().getCountry("/"+store.country!, { (response, error) in
                    if store.phone != ""{
                        if !(store.phone?.hasPrefix("+"))!{
                            store.phone = response![0].country_code+" "+store.phone!
                        }
                    }
                    let next = self.storyboard?.instantiateViewController(withIdentifier:"ShopDetailVC") as! ShopDetailVC
                    next.store = store
                    next.tit = store.name
                    self.navigationController?.pushViewController(next, animated: true)
                })
                
            }
        }
    }
    
    func showFilterView(_ show:Bool) {
        if !show
        {
            view.layoutIfNeeded()
            self.heightOfResetC.constant = 0
            self.resetFilterBtn.setTitle( "", for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else{
            view.layoutIfNeeded()
            self.heightOfResetC.constant = 40
            self.resetFilterBtn.setTitle( "Reset Filters", for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }

     func defaultViewSetting() {
        self.newBookBtn.isSelected = true
        self.usedBookBtn.isSelected = true
        self.museumShopsBtn.isSelected = true
    }
    
    // MARK: - MKMapView Delegate method
    
    // user tapped the disclosure button in the bridge callout
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // here we illustrate how to detect which annotation type was clicked on for its callout
        let annotation = view.annotation!
        if annotation is BookStoreAnnotation
        {

        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //         Center the map the first time we get a real location change.
        if userLocation.coordinate.latitude != 0.0 && userLocation.coordinate.longitude != 0.0 {
            if(self.tit == "My List") && currentLocation == nil {
                currentLocation = userLocation
                var region = MKCoordinateRegion()
                region = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(180, 180))
                mapView.setRegion(region, animated: true)
            }
            if (self.navigationController?.viewControllers.count) == 1 && currentLocation == nil {
                HUD.show(.progress)
                currentLocation = userLocation
                
//                let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,160934, 160934)
//                mapView.setRegion(mapView.regionThatFits(region), animated: true)
                if Reachable.isConnectedToNetwork(){
                    BookCitiesClient.sharedInstance().getStores({ (response, error) in
                        if error == nil{
                            self.stores = response
                            self.totalStores = self.stores
                            self.addAnnotationToMap()
                            var distanceArray = self.storesWithDistance()
                            var smallest = distanceArray[0]
                            var indx = 0;
                            for (index,distance) in distanceArray.enumerated() {
                                if smallest > distance
                                {
                                    smallest = distance
                                    indx = index
                                }
                            }
                            var region = MKCoordinateRegion()
                            if smallest < 3218.688{
                                self.mapView.setCenter(userLocation.coordinate, animated: true)
                                region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,3218.688, 3218.688)
                                mapView.setRegion(mapView.regionThatFits(region), animated: true)
                            }
                            else{
                                let annotation = self.mapAnnotations[indx]
                                let array = [annotation,mapView.userLocation]
                                mapView.showAnnotations(array, animated: true)
                            }
                            
                            HUD.hide()
                        }
                        
                    })
                }
                else{
                    HUD.hide()
                    let alert = UIAlertController.init(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                        self.dismiss(animated:true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
//                geocoder.reverseGeocodeLocation(userLocation.location!, completionHandler:{(placemarks, error) in
//                    if placemarks != nil && (placemarks?.count)! > 0
//                    {
//                        self.placemark = (placemarks?[0])!
//                        print(self.placemark.locality ?? "locality")
//                        print(self.placemark.administrativeArea ?? "administrativeArea")
//                        print(self.placemark.country ?? "country")
////                        let address = ["country_name":self.placemark.country,
////                                       "state_name":self.placemark.administrativeArea,
////                                       "city_name":self.placemark.locality]
//                        
//                        if self.placemark.locality != nil
//                        {
////                            BookCitiesClient.sharedInstance().getStores(address as [String : AnyObject], { (response, error) in
////                                if error == nil{
////                                    self.stores = response
////                                    self.totalStores = self.stores
////                                    self.addAnnotationToMap()
////                                    self.storesWithDistance()
////                                    if(self.mapAnnotations.count>1){
////                                        mapView.showAnnotations(self.mapAnnotations, animated: true)
////                                    }
////                                    HUD.hide()
////                                }
////                                
////                            })
//                        }
//                    }
//                    else
//                    {
//                        HUD.hide()
//                        // Handle the nil case if necessary.
//                    }
//                    
//                })

            }
            if let nv = (self.navigationController?.viewControllers.count) {
                if nv > 2 {
                    if currentLocation == nil && city == nil && !(self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-2] is ShopDetailVC)
                    {
                        currentLocation = userLocation
                        self.mapView.setCenter(userLocation.coordinate, animated: true)
                        if(self.mapAnnotations.count>1){
                            mapView.showAnnotations(self.mapAnnotations, animated: true)
                        }
                        
                        //                    let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,2000, 2000)
                        //                    mapView.setRegion(mapView.regionThatFits(region), animated: true)
                    }
                }
            }

        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied {
            let alert = UIAlertController.init(title: "Location Disabled", message: "Please enable location services in the Settings app.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if status == CLAuthorizationStatus.authorizedWhenInUse {
            self.mapView.showsUserLocation = true
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var returnedAnnotationView: MKAnnotationView? = nil
        
        // in case it's the user location, we already have an annotation, so just return nil
        if !(annotation is MKUserLocation) {
                if annotation is BookStoreAnnotation {  // BookStore
                returnedAnnotationView = BookStoreAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
                // provide the annotation view's image
                returnedAnnotationView!.image = UIImage(named:(annotation as! BookStoreAnnotation).imageName!)
                
                 if (self.navigationController?.viewControllers.count)! > 1 && !(self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-2] is ShopDetailVC) {
                    let rightButton = UIButton(type: .detailDisclosure)
                    rightButton.tintColor = UIColor.black
                    rightButton.tag = (annotation as! BookStoreAnnotation).tag!
                    rightButton.addTarget(self, action: #selector(MyMapVC.buttonAction(_:)), for: .touchUpInside)
                    returnedAnnotationView!.rightCalloutAccessoryView = rightButton
                }
                if (self.navigationController?.viewControllers.count) == 1
                {
                    let rightButton = UIButton(type: .detailDisclosure)
                    rightButton.tintColor = UIColor.black
                    rightButton.tag = (annotation as! BookStoreAnnotation).tag!
                    rightButton.addTarget(self, action: #selector(MyMapVC.buttonAction(_:)), for: .touchUpInside)
                    returnedAnnotationView!.rightCalloutAccessoryView = rightButton
                }
                if (self.navigationController?.viewControllers.first is MyListVC)
                {
                    let rightButton = UIButton(type: .detailDisclosure)
                    rightButton.tintColor = UIColor.black
                    rightButton.tag = (annotation as! BookStoreAnnotation).tag!
                    rightButton.addTarget(self, action: #selector(MyMapVC.buttonAction(_:)), for: .touchUpInside)
                    returnedAnnotationView!.rightCalloutAccessoryView = rightButton
                }
            }
        }
        return returnedAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    // MARK: - use to show the annotation  view
    fileprivate func gotoByAnnotationClass(_ annotationClass: AnyClass) {
        
        // user tapped "City" button in the bottom toolbar
        for annotation in self.mapAnnotations {
            if annotation.isKind(of: annotationClass) {
                // remove any annotations that exist
                self.mapView.removeAnnotations(self.mapView.annotations)
                // add just the city annotation
                self.mapView.addAnnotation(annotation)
                
                //                self.gotoDefaultLocation()
            }
        }
    }
    
    //MARK: -  Set Map to default Location
    fileprivate func gotoDefaultLocation(_ city:JSONCity) {
        mapView.showAnnotations(mapAnnotations, animated: true)
//        var address = [String:String]()
//        BookCitiesClient.sharedInstance().getCityOrigin([String : AnyObject](),id: city.id,completionHandlerForCityOrigin:{
//        (response,error)in
//            let state = JSONState.stateFromResults(response?["state"] as! [[String : AnyObject]])
//            print(state[0].name)
//            let country = JSONCountry.countryFromResults(response?["country"] as! [[String : AnyObject]])
//            print(country[0].name)
//            address = ["city":city.name ?? "",
//                                       "state":state[0].name,
//                                    "country": country[0].name];
//            self.geocoder.geocodeAddressDictionary(address, completionHandler: { (placemark,error) in
//                if(error == nil){
//                    let placemarkss:CLPlacemark = (placemark?.last)!
//                    var region:MKCoordinateRegion = MKCoordinateRegion()
//                    region.center.latitude = (placemarkss.location?.coordinate.latitude)!
//                    region.center.longitude = (placemarkss.location?.coordinate.longitude)!
//                    region.span = MKCoordinateSpanMake(0.009, 0.009)
//                    self.mapView.setRegion(region, animated: true)
//                }
//                else{
//                    print(error ?? "No city Location there and no error also")
//                }
//            })
//
//        })
//        
        
    }

    func goToStoreLocation(store:JSONStore,span : Double)
    {
        if(store.longitude == "" || store.latitude == "") {
            let alert = UIAlertController(title: Constants.Alert.TitleLocationNotFound, message: Constants.Alert.MessageLocationNotFound, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            var region:MKCoordinateRegion = MKCoordinateRegion()
            region.center.latitude = Double(store.latitude!)!
            region.center.longitude =  Double(store.longitude!)!
            region.span = MKCoordinateSpanMake(span, span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    // get PinImage
    func getStoreTypeImage(_ index:Int)->String{
        
        if stores![index].is_new_books == "1" && (stores![index].is_used_books == "1") && (stores![index].is_museumshops == "1")
        {
            return ""
        }
        else if stores![index].is_new_books == "0" && (stores![index].is_used_books == "1") && (stores![index].is_museumshops == "1")
        {
            return Constants.image.GreenBluePin
        }
        else if stores![index].is_new_books == "1" && (stores![index].is_used_books == "0") && (stores![index].is_museumshops == "1")
        {
            return Constants.image.RedGreenPin
        }
        else if stores![index].is_new_books == "1" && (stores![index].is_used_books == "1") && (stores![index].is_museumshops == "0")
        {
            return Constants.image.BlueRedPin
        }
        else if stores![index].is_new_books == "0" && (stores![index].is_used_books == "0") && (stores![index].is_museumshops == "1"){
            return Constants.image.GreenPin
        }
        else if stores![index].is_new_books == "1" && (stores![index].is_used_books == "0") && (stores![index].is_museumshops == "0"){
            return Constants.image.RedPin
        }
        else if stores![index].is_new_books == "0" && (stores![index].is_used_books == "1") && (stores![index].is_museumshops == "0"){
            return Constants.image.BluePin
        }
        else {
            return ""
        }
    }

    func addAnnotationToMap() {
            self.mapAnnotations = []
            if let storesList = stores{
                var i=0;
                for store in storesList{
                    let storeAnnotation = BookStoreAnnotation()
                    storeAnnotation.title = store.name
                    storeAnnotation.subtitle = store.address
                    storeAnnotation.store = store
                    storeAnnotation.tag = Int(store.id!)
                    storeAnnotation.imageName = getStoreTypeImage(i)
                    if(store.longitude != "" || store.latitude != "") {
                        storeAnnotation.coordinate = CLLocationCoordinate2DMake(Double(store.latitude!)!, Double(store.longitude!)!)
                        self.mapAnnotations.append(storeAnnotation)
                    }
                    
                    i += 1
                }
            }
        self.mapView.removeAnnotations(self.mapView.annotations)
        // add all the custom annotations
        self.mapView.addAnnotations(self.mapAnnotations)
    }
    
    func storesWithDistance() -> Array<Double>{
        var distanceArray = Array<Double>()
        for store in self.stores! {
            if(store.longitude != "" || store.latitude != "") {
                let storeLocation = CLLocation(latitude: Double(store.latitude!)!, longitude: Double(store.longitude!)!)
                let distance = currentLocation?.location?.distance(from: storeLocation)
                let miles = distance!
                distanceArray.append(miles)
            }
        }
        return distanceArray
    }
    
    
    
        /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
