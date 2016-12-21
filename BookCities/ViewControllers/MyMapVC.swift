//
//  MyMapVC.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/10/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import MapKit
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar Update
        self.navigationItem.title = tit
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        totalStores = stores
        self.mapView.delegate = self
        locationManager = CLLocationManager()
        
        // Gets user permission use location while the app is in the foreground.
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
//        let buttonItem = MKUserTrackingBarButtonItem(mapView: self.mapView)
//        self.navigationItem.leftBarButtonItem = buttonItem
        
        self.geocoder = CLGeocoder()
        // create out annotations array (in this example only 3)
        self.addAnnotationToMap()
//        // annotation for the City of San Francisco
//        let sfAnnotation = SFAnnotation()
//        self.mapAnnotations.append(sfAnnotation)
//        
//        // annotation for Golden Gate Bridge
//        let bridgeAnnotation = BridgeAnnotation()
//        self.mapAnnotations.append(bridgeAnnotation)
//        
//        // annotation for Fisherman's Wharf
//        let wharfAnnotation = WharfAnnotation()
//        self.mapAnnotations.append(wharfAnnotation)
        
        // annotation for Japanese Tea Garden
        
//        let item = CustomAnnotation()
//        item.place = "Tea Garden"
//        item.imageName = "logo"
//        item.coordinate = CLLocationCoordinate2DMake(37.770, -122.4709)
        
//        self.mapAnnotations.append(item)
        self.mapView.showsUserLocation = true
        if let currentCity = city {
             self.gotoDefaultLocation(currentCity)
        }
        else{
            if (self.navigationController?.viewControllers.count)! > 1 {
            if self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-2] is ShopDetailVC {
                goToStoreLocation(store: (self.stores?[0])!)
            }
            }
        }
        //        let region = MKCoordinateRegionMakeWithDistance((currentLocation!.coordinate),2000, 2000)
        //        self.gotoDefaultLocation(newRegion:mapView.regionThatFits(region))
        setView()
        if (self.navigationController?.viewControllers.count) == 1{
            newBookBtn.isHidden = true
            usedBookBtn.isHidden = true
            museumShopsBtn.isHidden = true
        }
        if (self.navigationController?.viewControllers.count)! > 1 && (self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-2] is ShopDetailVC)
        {
            newBookBtn.isHidden = true
            usedBookBtn.isHidden = true
            museumShopsBtn.isHidden = true

        }
    }
    
    func setView(){
        newBookBtn.isSelected = true
        usedBookBtn.isSelected = true
        museumShopsBtn.isSelected = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
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
            self.heightOfResetC.constant = 30
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
//        if annotation is BridgeAnnotation {
//            // user tapped the Golden Gate Bridge annotation
//            //
//            // note, we handle the accessory button press in "buttonAction"
//        }
        if annotation is BookStoreAnnotation
        {

        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //         Center the map the first time we get a real location change.
        
        if userLocation.coordinate.latitude != 0.0 && userLocation.coordinate.longitude != 0.0 {
            
            if (self.navigationController?.viewControllers.count) == 1 && currentLocation == nil {
                currentLocation = userLocation
                self.mapView.setCenter(userLocation.coordinate, animated: true)
                let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,2000, 2000)
                mapView.setRegion(mapView.regionThatFits(region), animated: true)
                
                // Lookup the information for the current location of the user.
                geocoder.reverseGeocodeLocation(mapView.userLocation.location!, completionHandler:{(placemarks, error) in
                    if placemarks != nil && (placemarks?.count)! > 0
                    {
                        self.placemark = (placemarks?[0])!
                        print(self.placemark.locality ?? "locality")
                        print(self.placemark.administrativeArea ?? "administrativeArea")
                        print(self.placemark.country ?? "country")
                        if let cityName = self.placemark.locality
                        {
                            BookCitiesClient.sharedInstance().getStores(["city":cityName as AnyObject], { (response, error) in
                                self.stores = response
                                self.totalStores = self.stores
                                self.addAnnotationToMap()
                            })
                        }
                    }
                    else
                    {
                        // Handle the nil case if necessary.
                    }
                    
                })
            }
            if (self.navigationController?.viewControllers.count)! > 1 {
                if currentLocation == nil && city == nil && !(self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-2] is ShopDetailVC)
                {
                    currentLocation = userLocation
                    self.mapView.setCenter(userLocation.coordinate, animated: true)
                    let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,2000, 2000)
                    mapView.setRegion(mapView.regionThatFits(region), animated: true)
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
            // handle our custom annotations
            //
            if annotation is BridgeAnnotation { // for Golden Gate Bridge
                returnedAnnotationView = BridgeAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
                
                // add a detail disclosure button to the callout which will open a new view controller page or a popover
                //
                // note: when the detail disclosure button is tapped, we respond to it via:
                //       calloutAccessoryControlTapped delegate method
                //
                // by using "calloutAccessoryControlTapped", it's a convenient way to find out which annotation was tapped
                //
                let rightButton = UIButton(type: .detailDisclosure)
                rightButton.addTarget(self, action: #selector(MyMapVC.buttonAction(_:)), for: .touchUpInside)
                returnedAnnotationView!.rightCalloutAccessoryView = rightButton
            } 
//                else if annotation is WharfAnnotation { // for Fisherman's Wharf
//                returnedAnnotationView = WharfAnnotation.createViewAnnotationForMapView(self.mapView,  annotation: annotation)
//                
//                // provide an image view to use as the accessory view's detail view.
//                let imageView = UIImageView(image: UIImage(named: "logo"))
//                returnedAnnotationView!.detailCalloutAccessoryView = imageView;
//            } else if annotation is SFAnnotation {   // for City of San Francisco
//                returnedAnnotationView = SFAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
//                
//                // provide the annotation view's image
//                returnedAnnotationView!.image = UIImage(named: "info")
//                
//                // provide the left image icon for the annotation
//                let sfIconView = UIImageView(image: UIImage(named: "logo"))
//                returnedAnnotationView!.leftCalloutAccessoryView = sfIconView
//            } else if annotation is CustomAnnotation {  // for Japanese Tea Garden
//                returnedAnnotationView = CustomAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
//            }
            else if annotation is BookStoreAnnotation {  // for Japanese Tea Garden
                returnedAnnotationView = BookStoreAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
                // provide the annotation view's image
                returnedAnnotationView!.image = UIImage(named:(annotation as! BookStoreAnnotation).imageName!)
                 if !(self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-2] is ShopDetailVC) {
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
    
    @objc func buttonAction(_ button: UIButton) {
        print(button.tag)
        for store in stores! {
            if Int(store.id!)! == button.tag
            {
                let next = self.storyboard?.instantiateViewController(withIdentifier:"ShopDetailVC") as! ShopDetailVC
                next.store = store
                self.navigationController?.pushViewController(next, animated: true)
            }
        }
    }
    
    //MARK: -  Set Map to default Location
    fileprivate func gotoDefaultLocation(_ city:JSONCity) {
        var address = [String:String]()
        BookCitiesClient.sharedInstance().getCityOrigin([String : AnyObject](),id: city.id,completionHandlerForCityOrigin:{
        (response,error)in
            let state = JSONState.stateFromResults(response?["state"] as! [[String : AnyObject]])
            print(state[0].name)
            let country = JSONCountry.countryFromResults(response?["country"] as! [[String : AnyObject]])
            print(country[0].name)
            address = ["city":city.name ?? "",
                                       "state":state[0].name,
                                    "country": country[0].name];
            self.geocoder.geocodeAddressDictionary(address, completionHandler: { (placemark,error) in
                if(error == nil){
                    let placemarkss:CLPlacemark = (placemark?.last)!
                    var region:MKCoordinateRegion = MKCoordinateRegion()
                    region.center.latitude = (placemarkss.location?.coordinate.latitude)!
                    region.center.longitude = (placemarkss.location?.coordinate.longitude)!
                    region.span = MKCoordinateSpanMake(0.09, 0.09)
                    self.mapView.setRegion(region, animated: true)
                }
                else{
                    print(error ?? "No city Location there and no error also")
                }
            })

        })
        
        
    }

    func goToStoreLocation(store:JSONStore)
    {
        var region:MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = Double(store.latitude!)!
        region.center.longitude =  Double(store.longitude!)!
        region.span = MKCoordinateSpanMake(0.09, 0.09)
        self.mapView.setRegion(region, animated: true)
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
                    storeAnnotation.coordinate = CLLocationCoordinate2DMake(Double(store.latitude!)!, Double(store.longitude!)!)
                    self.mapAnnotations.append(storeAnnotation)
                    i += 1
                }
            }
        self.mapView.removeAnnotations(self.mapView.annotations)
        // add all the custom annotations
        self.mapView.addAnnotations(self.mapAnnotations)
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
