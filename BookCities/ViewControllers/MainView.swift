//
//  MainView.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/7/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import PKHUD
class MainView: UIViewController {

    @IBOutlet weak var chooseACityBtn: BorderButton!
    @IBOutlet weak var nearMeBtn: BorderButton!
    @IBOutlet weak var myListBtn: BorderButton!
    @IBOutlet weak var saveOfflineDataBtn: BorderButton!
    
    @IBOutlet weak var infoBtn: UIButton!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        if(!CoreDataManager.sharedInstance().haveCategories()){
        if Reachable.isConnectedToNetwork() == true
        {
            
            BookCitiesClient.sharedInstance().getCategories({
                (response, error) in
                for catergory in response!
                {
                    CoreDataManager.sharedInstance().saveCategory(catergory.name!, id: catergory.id!)
                }
            })

        }
        else
        {
            let alert = UIAlertController(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Function to deal with view editing
    func setViews()
    {
        self.saveOfflineDataBtn.isHidden = true
    }
    
    // MARK: - Button Actions
    @IBAction func chooseACityBtnAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier:"CitiesVC") as! CitiesVC
        let nv:UINavigationController = UINavigationController(rootViewController: next)
        self.present(nv, animated: true, completion: nil)
    }
    
    @IBAction func nearMeBtnAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier:"MyMapVC") as! MyMapVC
        next.tit = "Near Me"
        let nv:UINavigationController = UINavigationController(rootViewController: next)
        present(nv, animated: true, completion: nil)
    }
    
    @IBAction func myListBtnAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier:"MyListVC") as! MyListVC
        next.tit = "My Place"
        if CoreDataManager.sharedInstance().haveStore(){
            next.stores = JSONStore.storeFromCoreData(CoreDataManager.sharedInstance().getStores() as! [Store])
            let nv:UINavigationController = UINavigationController(rootViewController: next)
            self.present(nv, animated: true, completion: nil)
        }
        else if Reachable.isConnectedToNetwork() == true
        {
            BookCitiesClient.sharedInstance().getStores({
                (response,error) in
                next.stores = response
                let nv:UINavigationController = UINavigationController(rootViewController: next)
                self.present(nv, animated: true, completion: nil)
            })
        }
        else
        {
            let alert = UIAlertController(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func infoBtnAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier:"InfosVC") as! InfosVC
        let nv:UINavigationController = UINavigationController(rootViewController: next)
        present(nv, animated: true, completion: nil)
    }
    @IBAction func saveOfflineDataBtnAction(_ sender: Any) {
        var storeCount = 0
       
        DispatchQueue(label: "com.bookcity.coredata").async{
        let queue = DispatchQueue(label: "com.bookcity.getcities")
        queue.async{
            if !CoreDataManager.sharedInstance().haveCity(){
                DispatchQueue.main.async {
                    HUD.show(.progress)
                }
                BookCitiesClient.sharedInstance().getCities([String : AnyObject](), completionHandlerForCities:{
                    (response, error) in
                    if(error == nil)
                    {
                        print("get city")
                        DispatchQueue.global(qos: .default).async{
                        for data in response!{
                            CoreDataManager.sharedInstance().saveCity(data.value(forKey:Constants.JSONCityResponseKey.Name) as! String, id: data.value(forKey:Constants.JSONCityResponseKey.Id) as! String, stateId: data.value(forKey:Constants.JSONCityResponseKey.State_id) as! String, countryId: data.value(forKey:Constants.JSONCityResponseKey.Country_id) as! String)
                        }
                        storeCount += 1
                        print("offline city save")
                        DispatchQueue.main.async {
                                HUD.flash(.success, delay: 1.0)
                            }
                      }
                    }
                    
                })
            }
        }
            if !CoreDataManager.sharedInstance().haveStore(){
                let storeQueue = DispatchQueue(label: "com.bookcity.getstores")
                storeQueue.async {
                    DispatchQueue.main.async {
                        HUD.show(.progress)
                    }
                    BookCitiesClient.sharedInstance().getStores({
                        (response, error) in
                        if(error == nil)
                        {
                            print("get store")
                            DispatchQueue.global(qos: .default).async{
                            for data in response!{
                                if !CoreDataManager.sharedInstance().haveStore(data.id!)
                                {
                                    CoreDataManager.sharedInstance().saveStores(data)
                                }
                            }
                            storeCount += 1
                            print("offline store save")
                            DispatchQueue.main.async {
                                    HUD.hide()
                                }
                            }
                        }
                    })
                    
                }
            }
            
            if !CoreDataManager.sharedInstance().haveState(){
                let stateQueue = DispatchQueue(label: "com.bookcity.getstates")
                stateQueue.async {
                    DispatchQueue.main.async {
                        HUD.show(.progress)
                    }
                    BookCitiesClient.sharedInstance().getState({
                        (response, error) in
                        if(error == nil)
                        {
                            print("get state")
                            DispatchQueue.global(qos: .default).async{
                            for data in response!{
                                CoreDataManager.sharedInstance().saveState(data.value(forKey:Constants.JSONStateResponseKey.Name) as! String, id: data.value(forKey:Constants.JSONStateResponseKey.Id) as! String, countryId: data.value(forKey:Constants.JSONStateResponseKey.Country_id) as! String)
                            }
                            
                            storeCount += 1
                            print("offline state save")
                            DispatchQueue.main.async {
                                    HUD.hide()
                                }
                        }
                        }
                    })
                    
                }
            }
            
            
            if !CoreDataManager.sharedInstance().haveCountry(){
                let stateQueue = DispatchQueue(label: "com.bookcity.getcountry")
                stateQueue.async {
                    DispatchQueue.main.async {
                        HUD.show(.progress)
                    }
                    BookCitiesClient.sharedInstance().getCountry({
                        (response, error) in
                        if(error == nil)
                        {
                            print("get country")
                            DispatchQueue.global(qos: .default).async{
                            for data in response!{
                                CoreDataManager.sharedInstance().saveCountry(data.value(forKey:Constants.JSONCountryResponseKey.Name) as! String, id: data.value(forKey:Constants.JSONCountryResponseKey.Id) as! String, sortName:data.value(forKey:Constants.JSONCountryResponseKey.SortName) as! String)
                            }
                            storeCount += 1
                            print("offline country save")
                            DispatchQueue.main.async {
                                HUD.hide()
                                }
                            }
                        }
                    })
                    
                }
            }
            DispatchQueue.main.async {
                if Reachable.isConnectedToNetwork() == false
                {
                    HUD.flash(.success, delay: 1.0)
                }
            }
        }
//        let  countries = JSONCountry.countryFromCoreData(CoreDataManager.sharedInstance().getCountry() as! [Country])
//        for con in countries{
//            print(con.id+"  "+con.name)
//        }
        let  states = JSONState.stateFromCoreData(CoreDataManager.sharedInstance().getState() as! [State])
        for stat in states{
            print(stat.id+"  "+stat.name)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
