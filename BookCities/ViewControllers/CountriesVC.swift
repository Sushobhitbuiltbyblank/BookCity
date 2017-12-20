//
//  CountriesVC.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 8/24/17.
//  Copyright © 2017 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class CountriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var cellIdentifier:String!
    var index:Int!
    var countries:Array<JSONCountry>!
    var tableIndex:Int = 20
    var page = 1
    var array:Array<Any>!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var searchBar:UISearchBar?
    var filteredCountries = [JSONCountry]()
    var searchActive:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        countries = Array<JSONCountry>()
        let parameter = ["hide_empty":1]
        if Reachable.isConnectedToNetwork() == true {
        BookCitiesClient.sharedInstance().getCountries(parameter as [String : AnyObject], {
                (response,error) in
                if error == nil{
                    let data = response as NSArray!
                    self.countries = data as! Array<JSONCountry>!
                    self.tableView.reloadData()
                }
                else
                {
                    print(error ?? "error to fatch cities")
                }
            })
        }
        else{
            let alert = UIAlertController(title: Constants.Alert.Title, message: Constants.Alert.Message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
                self.dismiss(animated:true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        self.titleL.font = UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))
        self.titleL.text = "Countries"
        self.navigationItem.title = "Countries"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        
        cellIdentifier = "citiCells"
        tableView.register(UINib(nibName: "CitiesTVCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        
        // Searching Bar Configuration
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 60))
        searchBar?.delegate = self
        searchBar?.placeholder = "Search Country Here"
        
        navigationController!.navigationBar.isTranslucent = false
        // The navigation bar's shadowImage is set to a transparent image.  In
        // addition to providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        navigationController!.navigationBar.shadowImage = #imageLiteral(resourceName: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Pixel"), for: .default)
        navigationItem.prompt = ""
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
    @IBAction func closeBtnAction(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
    }
    

    //MARK: - TableView Data Source function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive && searchBar?.text != "" {
            return filteredCountries.count
        }
        return countries.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CitiesTVCell
        
        if searchActive && searchBar?.text != "" {
            cell.titleLable?.text = filteredCountries[indexPath.row].name
        } else {
            cell.titleLable?.text = countries[indexPath.row].name
        }
        cell.selectionStyle = .none
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country:JSONCountry?
        if searchActive && searchBar?.text != "" {
            country = self.filteredCountries[indexPath.row]
        }
        else{
            country = self.countries[indexPath.row]
        }
        let next = self.storyboard?.instantiateViewController(withIdentifier: "CitiesVC") as! CitiesVC
        next.countryID = country?.id
        next.title = country?.name
        self.navigationController?.pushViewController(next, animated: true)
    }
    // MARK: - SearchController Delegate method
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCountries = countries.filter { countries in
            return (countries.name?.lowercased().hasPrefix(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableView.contentOffset.y < -100{
            self.tableView.tableHeaderView = searchBar
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

extension CountriesVC: UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController){
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountries = countries.filter { countries in
            return (countries.name?.lowercased().hasPrefix(searchText.lowercased()))!
        }
        if filteredCountries.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
    }
    
}
