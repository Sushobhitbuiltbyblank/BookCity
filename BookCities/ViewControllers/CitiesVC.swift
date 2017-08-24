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
    let searchController = UISearchController(searchResultsController: nil)
    var countryID:String?
    var filteredCities = [JSONCity]()
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar Update
        cities = Array<JSONCity>()
        guard let countryID = self.countryID else{return}
        let parameter = ["hide_empty":1,"country":countryID] as [String : AnyObject]
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
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                    self.dismiss(animated:true, completion: nil)
                }))
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
//        self.navigationItem.title = "Cities"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        
        cellIdentifier = "citiCells"
        tableView.register(UINib(nibName: "CitiesTVCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        
        // Searching Controller
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    
        let lowerBoader = CALayer()
        lowerBoader.backgroundColor = UIColor.black.cgColor
        lowerBoader.frame = CGRect(x: 0, y: searchController.searchBar.bounds.height-1, width: self.view.frame.width, height: 2.0)
        self.searchController.searchBar.layer.addSublayer(lowerBoader)
        self.searchController.searchBar.backgroundImage = UIImage()
        navigationController!.navigationBar.isTranslucent = false
        
        // The navigation bar's shadowImage is set to a transparent image.  In
        // addition to providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        navigationController!.navigationBar.shadowImage = #imageLiteral(resourceName: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Pixel"), for: .default)
        navigationItem.prompt = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - TableView Data Source function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCities.count
        }
        return cities.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CitiesTVCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.titleLable?.text = filteredCities[indexPath.row].name
        } else {
            cell.titleLable?.text = cities[indexPath.row].name
        }
        cell.selectionStyle = .none
        return cell;
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//       
//
//        if indexPath.row >= (cities.count)-1
//        {
//            let parameter = ["per_page":tableIndex,"page":page,"hide_empty":1];
//            page = page+1
//            if Reachable.isConnectedToNetwork() == true {
//                BookCitiesClient.sharedInstance().getCities(parameter as [String : AnyObject], completionHandlerForCities: {
//                    (response,error) in
//                    if error == nil{
//                        let data = response as Array<JSONCity>!
//                        for city in data!{
//                            self.cities.append(city)
//                        }
//                        self.tableView.reloadData()
//                        
//                    }
//                    else
//                    {
//                        print(error ?? "error to fetch cities")
//                    }
//                })
//            }
//            else{
//                let alert = UIAlertController(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//        
//    }
    
    // MARK: - Table View Delegate Function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isUserInteractionEnabled = false
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor(colorLiteralRed: 217/255, green: 217/255, blue: 217/255, alpha: 1)
//        tableView.deselectRow(at: indexPath, animated: true)
        var currentCity:JSONCity!
        if searchController.isActive && searchController.searchBar.text != "" {
            currentCity = filteredCities[indexPath.row]
        } else {
            currentCity = cities[indexPath.row]
        }
        let next = self.storyboard?.instantiateViewController(withIdentifier:"MyListVC") as! MyListVC
        if Reachable.isConnectedToNetwork() == true {
            BookCitiesClient.sharedInstance().getStores(["city":currentCity.id as AnyObject],{
                (response,error) in
                next.stores = response
                next.tit = currentCity.name
                next.city = currentCity
                BookCitiesClient.sharedInstance().getCountry("/"+currentCity.country_id, { (response, error) in
                    var storelist = Array<JSONStore>()
                    for store in next.stores! {
                        if store.phone != ""{
                            if !(store.phone?.hasPrefix("+"))!{
                                store.phone = response![0].country_code+" "+store.phone!
                            }
                        }
                        storelist.append(store)
                    }
                    next.stores = storelist
                    tableView.isUserInteractionEnabled = true
                    cell?.contentView.backgroundColor = UIColor.white
                    self.navigationController?.pushViewController(next, animated: true)
                })
            })
        }
//        else if CoreDataManager.sharedInstance().haveStore(){
//            next.stores = JSONStore.storeFromCoreData(CoreDataManager.sharedInstance().getStores() as! [Store])
//            next.tit = self.cities[indexPath.row].name
//            self.navigationController?.pushViewController(next, animated: true)
//        }
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
    
    func goBack(_ sender:AnyObject) -> ()
    {
        self.navigationController!.popViewController(animated: true)
    }

    // MARK: - SearchController Delegate method
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCities = cities.filter { city in
            return (city.name?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableView.contentOffset.y < -100{
            self.tableView.tableHeaderView = searchController.searchBar
        }

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
extension CitiesVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController){
         filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
}

 
