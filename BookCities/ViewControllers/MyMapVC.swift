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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar Update
        self.navigationItem.title = tit
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        self.mapView.delegate = self
        locationManager = CLLocationManager()
        // Gets user permission use location while the app is in the foreground.
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        let buttonItem = MKUserTrackingBarButtonItem(mapView: self.mapView)
        self.navigationItem.leftBarButtonItem = buttonItem
        self.geocoder = CLGeocoder()
        // create out annotations array (in this example only 3)
        self.mapAnnotations = []
        
        // annotation for the City of San Francisco
        let sfAnnotation = SFAnnotation()
        self.mapAnnotations.append(sfAnnotation)
        
        // annotation for Golden Gate Bridge
        let bridgeAnnotation = BridgeAnnotation()
        self.mapAnnotations.append(bridgeAnnotation)
        
        // annotation for Fisherman's Wharf
        let wharfAnnotation = WharfAnnotation()
        self.mapAnnotations.append(wharfAnnotation)
        
        // annotation for Japanese Tea Garden
        let itt = BookStoreAnnotation()
        itt.title = "sfjhj"
        itt.subtitle = "fiuhehf"
        itt.coordinate = CLLocationCoordinate2DMake(37.808333, -122.419281)
        self.mapAnnotations.append(itt)
        
        let item = CustomAnnotation()
        item.place = "Tea Garden"
        item.imageName = "logo"
        item.coordinate = CLLocationCoordinate2DMake(37.770, -122.4709)
        
        self.mapAnnotations.append(item)
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        // add all the custom annotations
        self.mapView.addAnnotations(self.mapAnnotations)
        self.mapView.showsUserLocation = true
        if let currentCity = city {
             self.gotoDefaultLocation(currentCity)
        }
        
        //        let region = MKCoordinateRegionMakeWithDistance((currentLocation!.coordinate),2000, 2000)
        //        self.gotoDefaultLocation(newRegion:mapView.regionThatFits(region))
        
        
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
    
    // MARK: - MKMapView Delegate method
    
    // user tapped the disclosure button in the bridge callout
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // here we illustrate how to detect which annotation type was clicked on for its callout
        let annotation = view.annotation!
        if annotation is BridgeAnnotation {
            // user tapped the Golden Gate Bridge annotation
            //
            // note, we handle the accessory button press in "buttonAction"
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//         Center the map the first time we get a real location change.
        
        if userLocation.coordinate.latitude != 0.0 && userLocation.coordinate.longitude != 0.0 {
            if currentLocation == nil && city == nil
            {
                currentLocation = userLocation
                self.mapView.setCenter(userLocation.coordinate, animated: true)
                let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,2000, 2000)
                mapView.setRegion(mapView.regionThatFits(region), animated: true)
            }
        }
//                let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,2000, 2000)
//                mapView.setRegion(mapView.regionThatFits(region), animated: true)
                // Lookup the information for the current location of the user.
//                geocoder.reverseGeocodeLocation(mapView.userLocation.location!, completionHandler:{(placemarks, error) in
//                    if placemarks != nil && (placemarks?.count)! > 0
//                    {
//                        self.placemark = (placemarks?[0])!
//                        print(self.placemark.thoroughfare ?? "thoroughfare")
//                        print(self.placemark.subThoroughfare ?? "subThoroughfare")
//                        print(self.placemark.locality ?? "locality")
//                        print(self.placemark.subLocality ?? "subLocality")
//                        print(self.placemark.administrativeArea ?? "administrativeArea")
//                        print(self.placemark.subAdministrativeArea ?? "subAdministrativeArea")
//                        print(self.placemark.country ?? "country")
//                        print(self.placemark.isoCountryCode ?? "isoCountryCode")
//                        print(self.placemark.postalCode ?? "postalcode")
//                    }
//                    else
//                    {
//                        // Handle the nil case if necessary.
//                    }
//        
//                } )
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
            } else if annotation is WharfAnnotation { // for Fisherman's Wharf
                returnedAnnotationView = WharfAnnotation.createViewAnnotationForMapView(self.mapView,  annotation: annotation)
                
                // provide an image view to use as the accessory view's detail view.
                let imageView = UIImageView(image: UIImage(named: "logo"))
                returnedAnnotationView!.detailCalloutAccessoryView = imageView;
            } else if annotation is SFAnnotation {   // for City of San Francisco
                returnedAnnotationView = SFAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
                
                // provide the annotation view's image
                returnedAnnotationView!.image = UIImage(named: "info")
                
                // provide the left image icon for the annotation
                let sfIconView = UIImageView(image: UIImage(named: "logo"))
                returnedAnnotationView!.leftCalloutAccessoryView = sfIconView
            } else if annotation is CustomAnnotation {  // for Japanese Tea Garden
                returnedAnnotationView = CustomAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
            }
            else if annotation is BookStoreAnnotation {  // for Japanese Tea Garden
                returnedAnnotationView = BookStoreAnnotation.createViewAnnotationForMapView(self.mapView, annotation: annotation)
                // provide the annotation view's image
                returnedAnnotationView!.image = UIImage(named: "info")
                let rightButton = UIButton(type: .detailDisclosure)
                rightButton.addTarget(self, action: #selector(MyMapVC.buttonAction(_:)), for: .touchUpInside)
                returnedAnnotationView!.rightCalloutAccessoryView = rightButton
            }
        }
        
        return returnedAnnotationView
    }
    
    func rightButtonAction() {
        print("clicked")
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
        NSLog("")
        
    }
    
    //MARK: -  Set map to default Location
    fileprivate func gotoDefaultLocation(_ city:JSONCity) {
        print(city.name ?? "")
        print(city.state_id ?? "")
        print(city.country_id ?? "")
        print(JSONState.stateFromCDRecord(CoreDataManager.sharedInstance().getState(city.state_id)).name ?? "")
        print(JSONCountry.countryForCDRecord(CoreDataManager.sharedInstance().getCountry(city.country_id)).name ?? "")
        
        let address = ["city":city.name ?? "",
                       "state":JSONState.stateFromCDRecord(CoreDataManager.sharedInstance().getState(city.state_id)).name ?? "",
                       "country":JSONCountry.countryForCDRecord(CoreDataManager.sharedInstance().getCountry(city.country_id)).name ?? ""];
        geocoder.geocodeAddressDictionary(address, completionHandler: { (placemark,error) in
            if(error == nil){
                let placemarkss:CLPlacemark = (placemark?.last)!
                var region:MKCoordinateRegion = MKCoordinateRegion()
                region.center.latitude = (placemarkss.location?.coordinate.latitude)!
                region.center.longitude = (placemarkss.location?.coordinate.longitude)!
                region.span = MKCoordinateSpanMake(0.09, 0.09)
                self.mapView.setRegion(region, animated: true)
            }
            else{
                print(error ?? "erroroororror")
            }
        })
        
        
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
