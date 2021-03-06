//
//  MyListVC.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/8/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class MyListVC: UIViewController,UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resetFiltersBtn: UIButton!
    @IBOutlet weak var newBooksBtn: BorderButton!
    @IBOutlet weak var usedBooksBtn: BorderButton!
    @IBOutlet weak var museumshopsBtn: BorderButton!
    @IBOutlet weak var showOnMapBtn: BorderButton!
    @IBOutlet weak var filterByCategory: BorderButton!
    
    // MARK: - Picker related views
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancleBtn: UIButton!
    
    // MARK: - Constraints
    @IBOutlet weak var categoryContainerBottomC: NSLayoutConstraint!
    @IBOutlet weak var topCOfTableView: NSLayoutConstraint!
    @IBOutlet weak var heightOfResetC: NSLayoutConstraint!
    
    // MARK: - Other variables
    var cellIdentifier:String!
    var headerCellIdentifier:String!
    var stores:Array<JSONStore>?
    var tit: String?
    var categories:Array<Any>?
    var city:JSONCity?
    var totalStores:Array<JSONStore>?
    var cities: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultViewSetting()
        totalStores = stores
        categories = CoreDataManager.sharedInstance().getCategories()
        //registercellfor Table view
        cellIdentifier = "bookStoreCell"
        headerCellIdentifier = "headerViewCell"
        tableView.register(UINib(nibName: "BookStoreTVCell", bundle: nil), forCellReuseIdentifier:cellIdentifier)
        tableView.register(UINib(nibName: "headerViewCell", bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Data Source function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cities != nil {
            let twoDArray = getTwoDArray(cities: self.cities!, stores: stores!)
            return twoDArray[section].count
        }
        else{
            return stores!.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let cityArray = cities{
            return cityArray.count
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BookStoreTVCell
        if cities != nil {
            let twoDArray = getTwoDArray(cities: self.cities!, stores: stores!)
            cell.titleLable?.text = twoDArray[indexPath.section][indexPath.row].name
            if (stores?[indexPath.row].isFavorate)!{
                cell.favBookStoreImageV.image = UIImage.init(named: Constants.image.SelectedTriagle)
            }
            cell.bookstoreTypeImageV?.image = UIImage.init(named: getStoreTypeImage(indexPath.row))
            return cell

        }
        else{
            cell.titleLable?.text = stores?[indexPath.row].name
            if (stores?[indexPath.row].isFavorate)!{
                cell.favBookStoreImageV.image = UIImage.init(named: Constants.image.SelectedTriagle)
            }
            cell.bookstoreTypeImageV?.image = UIImage.init(named: getStoreTypeImage(indexPath.row))
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if cities != nil {
            let twoDArray = getTwoDArray(cities: self.cities!, stores: stores!)
            if twoDArray[section].count == 0 {
                return nil
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier) as! headerViewCell
                cell.mainLable.text = twoDArray[section][0].cityName
                cell.shareBtn.tag = section
                cell.shareBtn.addTarget(self, action: #selector(self.shareBtnAction(_:)), for: .touchUpInside)
                return cell
            }
        }
        else{
            return nil
        }
    }
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if cities != nil {
            let twoDArray = getTwoDArray(cities: self.cities!, stores: stores!)
            if twoDArray[section].count == 0 {
                return 0
            }
            else{
                return 50
            }
        }
        else{
            return 0
        }
    }
    // MARK: - Table View Delegate Function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = self.storyboard?.instantiateViewController(withIdentifier:"ShopDetailVC") as! ShopDetailVC
        if cities != nil {
            let twoDArray = getTwoDArray(cities: self.cities!, stores: stores!)
            next.tit = twoDArray[indexPath.section][indexPath.row].name
            next.store = twoDArray[indexPath.section][indexPath.row]
        }
        else{
            next.tit = stores?[indexPath.row].name
            next.store = stores?[indexPath.row]
        }
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    //MARK: - PICKER VIEW DATA SOURCE FUNCTION
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (categories?.count)!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (categories?[row] as AnyObject).value(forKeyPath: "name") as? String
    }
    
    //MARK: - PICKER VIEW DELEGATE FUNCTION
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        
//        let string = (categories?[row] as AnyObject).value(forKeyPath: "name") as? String
//        return NSAttributedString(string: string!, attributes: [NSForegroundColorAttributeName:UIColor.white])
//    }
    //MARK: - Change View setting
    func defaultViewSetting() {
        // NavigationBar Update
        self.navigationItem.title = tit
        // Add left button arrow image for pushed views
        let n: Int! = self.navigationController?.viewControllers.count
        if (n>1){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        }
        // change the title font of navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        self.newBooksBtn.isSelected = true
        self.usedBooksBtn.isSelected = true
        self.museumshopsBtn.isSelected = true
//        self.resetFiltersBtn.setTitle( "Reset Filters", for: .normal)
    }
    
    func showFilterView(_ show:Bool) {
            if !show
            {
                view.layoutIfNeeded()
                self.heightOfResetC.constant = 0
                self.resetFiltersBtn.setTitle( "", for: .normal)
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            else{
                view.layoutIfNeeded()
                self.heightOfResetC.constant = 30
                self.resetFiltersBtn.setTitle( "Reset Filters", for: .normal)
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
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
    
    @IBAction func resetFiltersBtnAction(_ sender: Any) {
        defaultViewSetting()
        showFilterView(false)
        stores = totalStores
        tableView.reloadData()
    }
    
    @IBAction func newBooksBtnAction(_ sender: Any) {
        self.usedBooksBtn.isSelected = false
        self.museumshopsBtn.isSelected = false
        self.newBooksBtn.isSelected = true
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
        tableView.reloadData()
    }
    
    @IBAction func usedBooksBtnAction(_ sender: Any) {
        self.museumshopsBtn.isSelected = false
        self.newBooksBtn.isSelected = false
        self.usedBooksBtn.isSelected = true
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
        tableView.reloadData()
    }
    
    @IBAction func museumshopsBtnAction(_ sender: Any) {
        self.newBooksBtn.isSelected = false
        self.usedBooksBtn.isSelected = false
        self.museumshopsBtn.isSelected = true
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
        tableView.reloadData()
    }
    
    @IBAction func showOnMapBtnAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier:"MyMapVC") as! MyMapVC
        if let currentCity = city{
            next.tit = currentCity.name
            next.city = currentCity
            next.stores = stores
        }
        else{
            next.stores = stores
        }
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func filterByCategoryBtnAction(_ sender: Any) {
        showCategoryPicker(true)
    }
    
     @objc func shareBtnAction(_ button: UIButton) {
        let twoDArray =  getTwoDArray(cities: self.cities!, stores: stores!)
        let storeList = twoDArray[button.tag]
        var data = [String]()
        for store in storeList {
            let header = store.name
            let gap = "\n"
            let link = "Link - "+(store.website)!
            let address = "Address - "+(store.address)!
            let phone = "Contact - "+(store.phone)! 
            data.append(header!+gap+link+gap+address+gap+phone+gap)
        }
        let textToShare = data
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)

    }
    // MARK: - CATEGORY CONTAINER BUTTONS ACTION
    @IBAction func doneBtnAction(_ sender: Any) {
        let row = categoryPicker.selectedRow(inComponent: 0)
        let value = categories?[row]
        var storesData:Array<JSONStore> = Array()
        for store in totalStores! {
            if self.containCategory(store: store,category: value as Any){
                storesData.append(store)
            }
        }
        stores = storesData
        tableView.reloadData()
        showCategoryPicker(false)
    }
    
    @IBAction func cancleBtnAction(_ sender: Any) {
        showCategoryPicker(false)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: - UTILITY METHOD FOR SUBVIEWS
    func showCategoryPicker(_ value:Bool) -> Void {
        if value{
            view.layoutIfNeeded()
            self.categoryContainerBottomC.constant = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else
        {
            self.view.layoutIfNeeded()
            self.categoryContainerBottomC.constant = -self.pickerContainerView.bounds.size.height
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - get the image according to the type of store
    func getStoreTypeImage(_ index:Int)->String{
        
        if stores![index].is_new_books == "1" && (stores![index].is_used_books == "1") && (stores![index].is_museumshops == "1")
        {
            return ""
        }
        else if stores![index].is_new_books == "0" && (stores![index].is_used_books == "1") && (stores![index].is_museumshops == "1")
        {
            return Constants.image.GreenBlueCircle
        }
        else if stores![index].is_new_books == "1" && (stores![index].is_used_books == "0") && (stores![index].is_museumshops == "1")
        {
            return Constants.image.RedGreenCircle
        }
        else if stores![index].is_new_books == "1" && (stores![index].is_used_books == "1") && (stores![index].is_museumshops == "0")
        {
            return Constants.image.BlueRedCircle
        }
        else if stores![index].is_new_books == "0" && (stores![index].is_used_books == "0") && (stores![index].is_museumshops == "1"){
            return Constants.image.GreenCircle
        }
        else if stores![index].is_new_books == "1" && (stores![index].is_used_books == "0") && (stores![index].is_museumshops == "0"){
            return Constants.image.RedCircle
        }
        else if stores![index].is_new_books == "0" && (stores![index].is_used_books == "1") && (stores![index].is_museumshops == "0"){
            return Constants.image.BlueCircle
        }
        else {
            return ""
        }
    }
    
    func getStoreTypeImage(_ section:Int, row:Int)->String{
        
        if cities != nil {
            let twoDArray = getTwoDArray(cities: self.cities!, stores: stores!)
            if twoDArray[section][row].is_new_books == "1" && (twoDArray[section][row].is_used_books == "1") && (twoDArray[section][row].is_museumshops == "1")
            {
                return ""
            }
            else if twoDArray[section][row].is_new_books == "0" && (twoDArray[section][row].is_used_books == "1") && (twoDArray[section][row].is_museumshops == "1")
            {
                return Constants.image.GreenBlueCircle
            }
            else if twoDArray[section][row].is_new_books == "1" && (twoDArray[section][row].is_used_books == "0") && (twoDArray[section][row].is_museumshops == "1")
            {
                return Constants.image.RedGreenCircle
            }
            else if twoDArray[section][row].is_new_books == "1" && (twoDArray[section][row].is_used_books == "1") && (twoDArray[section][row].is_museumshops == "0")
            {
                return Constants.image.BlueRedCircle
            }
            else if twoDArray[section][row].is_new_books == "0" && (twoDArray[section][row].is_used_books == "0") && (twoDArray[section][row].is_museumshops == "1"){
                return Constants.image.GreenCircle
            }
            else if twoDArray[section][row].is_new_books == "1" && (twoDArray[section][row].is_used_books == "0") && (twoDArray[section][row].is_museumshops == "0"){
                return Constants.image.RedCircle
            }
            else if twoDArray[section][row].is_new_books == "0" && (twoDArray[section][row].is_used_books == "1") && (twoDArray[section][row].is_museumshops == "0"){
                return Constants.image.BlueCircle
            }
            else {
                return ""
            }
        }
        else{
           return ""
        }
    }
        
    func containCategory(store:JSONStore,category:Any)-> Bool {
        let categoryString = store.books_category_ids
        let value:Categories = category as! Categories
        let id = value.value(forKeyPath: "id") as! String
        let catergoryArray = categoryString?.characters.split{$0 == ":"}.map(String.init)
        for cat in catergoryArray! {
            if cat == id {
                return true
            }
        }
        return false
    }
    
    func getTwoDArray(cities:Array<String>,stores:Array<JSONStore>) -> [[JSONStore]] {
        var twoDArray = [[JSONStore]]()
        for city in cities {
            var storeInCity = Array<JSONStore>()
            for store in stores {
                if store.city == city{
                    storeInCity.append(store)
                }
            }
            twoDArray.append(storeInCity)
        }
        return twoDArray
    }
    
    
}
