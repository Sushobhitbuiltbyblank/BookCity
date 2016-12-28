//
//  CitiesVC.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/8/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class CitiesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLable: UILabel!
    var cellIdentifier:String!
    var index:Int!
    var cities:Array<JSONCity>!
    var tableIndex:Int = 20
    var page = 1
    var arary:Array<Any>!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar Update
        cities = Array<JSONCity>()
        let parameter = ["per_page":tableIndex,"page":page];
        page = page+1
        if Reachable.isConnectedToNetwork() == true {
            BookCitiesClient.sharedInstance().getCities(parameter as [String : AnyObject], completionHandlerForCities: {
                (response,error) in
                if error == nil{
                    let data = response as NSArray!
                    self.cities = data as! Array<JSONCity>!
                    self.tableView.reloadData()
                }
                else
                {
                    print(error ?? "error to fatch cities")
                }
            })
        }
        else{
            if !CoreDataManager.sharedInstance().haveCity(){
                let alert = UIAlertController(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }
            else{
                if cities.count == 0{
                    DispatchQueue(label: "com.test.fatchcoredata").async {
                         self.cities = JSONCity.cityFromCoreData(CoreDataManager.sharedInstance().getCities() as! [City])
                        DispatchQueue.main.async {
                             self.tableView.reloadData()
                        }
                       
                    }
                }
            }
        }
        self.navigationItem.title = "Cities"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        
        cellIdentifier = "citiCells"
        tableView.register(UINib(nibName: "CitiesTVCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Data Source function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CitiesTVCell
        cell.titleLable?.text = cities[indexPath.row].name
        return cell;
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= (cities.count)-1
        {
            let parameter = ["per_page":tableIndex,"page":page];
            page = page+1
            if Reachable.isConnectedToNetwork() == true {
                BookCitiesClient.sharedInstance().getCities(parameter as [String : AnyObject], completionHandlerForCities: {
                    (response,error) in
                    if error == nil{
                        let data = response as Array<JSONCity>!
                        for city in data!{
                            self.cities.append(city)
                        }
                        self.tableView.reloadData()
                        
                    }
                    else
                    {
                        print(error ?? "error to fetch cities")
                    }
                })
            }
            else{
                let alert = UIAlertController(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    // MARK: - Table View Delegate Function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCity:JSONCity = cities[indexPath.row]
        let next = self.storyboard?.instantiateViewController(withIdentifier:"MyListVC") as! MyListVC
        if Reachable.isConnectedToNetwork() == true {
            tableView.isUserInteractionEnabled = false
            BookCitiesClient.sharedInstance().getStores(["city":currentCity.id as AnyObject],{
                (response,error) in
                next.stores = response
                next.tit = currentCity.name
                next.city = currentCity
                tableView.isUserInteractionEnabled = true
                self.navigationController?.pushViewController(next, animated: true)
            })
        }
        else if CoreDataManager.sharedInstance().haveStore(){
            next.stores = JSONStore.storeFromCoreData(CoreDataManager.sharedInstance().getStores() as! [Store])
            next.tit = self.cities[indexPath.row].name
            self.navigationController?.pushViewController(next, animated: true)
        }
        else {
            let alert = UIAlertController(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Button Actions
    func closeBtnAction(_ sender:AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
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
