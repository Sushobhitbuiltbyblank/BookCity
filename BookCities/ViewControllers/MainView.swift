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
    //    @IBOutlet weak var saveOfflineDataBtn: BorderButton!
    
    @IBOutlet weak var infoBtn: UIButton!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        if Reachable.isConnectedToNetwork() == true
        {
            BookCitiesClient.sharedInstance().getCategories({
                (response, error) in
                for catergory in response!
                {
                    if !CoreDataManager.sharedInstance().haveCategory(catergory.id!){
                        CoreDataManager.sharedInstance().saveCategory(catergory.name!, id: catergory.id!)
                    }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Function to deal with view editing
    func setViews()
    {
        //        self.saveOfflineDataBtn.isHidden = true
        self.chooseACityBtn.addBorder(width: 1.0)
        self.nearMeBtn.addBorder(width: 1.0)
        self.myListBtn.addBorder(width: 1.0)
    }
    
    // MARK: - Button Actions
    @IBAction func chooseACityBtnAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier:"CountriesVC") as! CountriesVC
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
        myListBtn.setBackgroundImage( UIImage(named:"selectedButton"), for: .normal)
        let next = self.storyboard?.instantiateViewController(withIdentifier:"MyListVC") as! MyListVC
        next.tit = "My List"
        if CoreDataManager.sharedInstance().haveStore(){
            var citiWiseStore = JSONStore.storeFromCoreData(CoreDataManager.sharedInstance().getStores() as! [Store])
            if Reachable.isConnectedToNetwork(){
                HUD.show(.progress)
                BookCitiesClient.sharedInstance().getStores({ (response, error) in
                    if error == nil{
                        for (index,value) in citiWiseStore.enumerated(){
                            if !self.containStore(value, StoreList: response!){
                                citiWiseStore.remove(at: index)
                                CoreDataManager.sharedInstance().deleteStore(storeID: value.id!)
                            }
                        }
                        citiWiseStore = self.updateCoreData(citiWiseStore,response!)
                        var citiArray = Array<String>()
                        for store in citiWiseStore {
                            let city = store.cityName
                            if !citiArray.contains(city!){
                                citiArray.append(city!)
                            }
                        }
                        next.cities = citiArray.sorted(by: {$0 < $1})
                        next.stores = citiWiseStore
                        self.myListBtn.setBackgroundImage( UIImage(named:"backBtnWhite"), for: .normal)
                        HUD.hide()
                        let nv:UINavigationController = UINavigationController(rootViewController: next)
                        self.present(nv, animated: true, completion: nil)
                    }
                    else{
                        HUD.hide()
                    }
                })
            }
            else{
                var citiArray = Array<String>()
                for store in citiWiseStore {
                    let city = store.city
                    if !citiArray.contains(city!){
                        citiArray.append(city!)
                    }
                }
                next.cities = citiArray
                next.stores = citiWiseStore
                let nv:UINavigationController = UINavigationController(rootViewController: next)
                self.present(nv, animated: true, completion: nil)
                self.myListBtn.setBackgroundImage( UIImage(named:"backBtnWhite"), for: .normal)
            }
            
        }
        else
        {
            let alert = UIAlertController(title: Constants.Alert.TitleNofavStore, message: Constants.Alert.MessageNoFavStore, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.myListBtn.setBackgroundImage( UIImage(named:"backBtnWhite"), for: .normal)
        }
    }
    
    @IBAction func infoBtnAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier:"InfosVC") as! InfosVC
        let nv:UINavigationController = UINavigationController(rootViewController: next)
        present(nv, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // Check store contain in list
    func containStore(_ store:JSONStore, StoreList:[JSONStore]) -> Bool{
        for stor in StoreList{
            if store.id == stor.id{
                return true
            }
        }
        return false
    }
    
    func updateCoreData(_ cdstores:[JSONStore], _ stores:[JSONStore]) -> [JSONStore]
    {
        for cdstore in cdstores {
            for store in stores {
                if store.id == cdstore.id {
                    CoreDataManager.sharedInstance().saveStores(store, cityName: cdstore.cityName!)
                }
            }
        }
        return JSONStore.storeFromCoreData(CoreDataManager.sharedInstance().getStores() as! [Store])
    }
}
