//
//  MainView.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/7/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import ReachabilitySwift
class MainView: UIViewController {

    @IBOutlet weak var chooseACityBtn: BorderButton!
    @IBOutlet weak var nearMeBtn: BorderButton!
    @IBOutlet weak var myListBtn: BorderButton!
    @IBOutlet weak var infoBtn: UIButton!
    let reachability = Reachability()!
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
