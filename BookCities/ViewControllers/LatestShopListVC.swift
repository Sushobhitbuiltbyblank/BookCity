//
//  LatestShopListVC.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 6/20/17.
//  Copyright © 2017 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import PKHUD

class LatestShopListVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var cellIdentifier = "citiCells"
    var storeID:String?
    var cityName:String?
    var notificationList:Array<Any>{
        return CoreDataManager.sharedInstance().getNotifications()
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isTranslucent = false
        
        // The navigation bar's shadowImage is set to a transparent image.  In
        // addition to providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        navigationController!.navigationBar.shadowImage = #imageLiteral(resourceName: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Pixel"), for: .default)
        navigationItem.prompt = ""
        //        self.navigationItem.title = "Notification"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        if let storeid = self.storeID{
        HUD.show(.progress)
        if Reachable.isConnectedToNetwork(){
            BookCitiesClient.sharedInstance().getStore(storeid, { (response, error) in
                HUD.hide()
                let store = response![0]
                store.cityName = self.cityName
                let next = self.storyboard?.instantiateViewController(withIdentifier:"ShopDetailVC") as! ShopDetailVC
                next.store = store
                next.tit = store.name
                let nv = UINavigationController(rootViewController: next)
                self.present(nv, animated: true, completion: nil)
            })
        }
        }
        else{
            HUD.hide()
            let alert = UIAlertController.init(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                self.dismiss(animated:true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        tableView.register(UINib(nibName: "CitiesTVCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if let _ = self.storeID{
        }
        else{
        if self.notificationList.isEmpty {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let mainView = storyboard.instantiateViewController(withIdentifier:"MainView") as! MainView
            self.present(mainView, animated: false, completion: nil)
        }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.storeID = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeBtnAction(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let mainView = storyboard.instantiateViewController(withIdentifier:"MainView") as! MainView
        self.present(mainView, animated: false, completion: nil)

    }
    //MARK: - TableView Data Source function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CitiesTVCell
        cell.titleLable.text = (notificationList[indexPath.row] as AnyObject).value(forKeyPath: "name") as? String
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor(colorLiteralRed: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        HUD.show(.progress)
        let id = ((notificationList[indexPath.row] as AnyObject).value(forKeyPath: "id") as? String)!
        if Reachable.isConnectedToNetwork(){
        BookCitiesClient.sharedInstance().getStore(id, { (response, error) in
            HUD.hide()
            let store = response![0]
            let next = self.storyboard!.instantiateViewController(withIdentifier:"ShopDetailVC") as! ShopDetailVC
            next.store = store
            next.tit = store.name
            self.navigationController?.pushViewController(next, animated: true)
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
        CoreDataManager.sharedInstance().deleteNotification(id)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
