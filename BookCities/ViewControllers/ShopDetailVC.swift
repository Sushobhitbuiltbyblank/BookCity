//
//  ShopDetailVC.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/14/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import AlamofireImage

protocol UpdateFavorate {
    func updateTableView(indexpath:IndexPath)
    func updateTableViewOnly()
}

class ShopDetailVC: UIViewController , UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var favorateBtn: BorderButton!
    @IBOutlet weak var shareBtn: BorderButton!
    @IBOutlet weak var showOnMapBtn: BorderButton!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLable: SRCopyableLabel!
    @IBOutlet weak var address2Lable: UILabel!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var contentOfScrollView: UIView!
    @IBOutlet weak var websiteLinkBtn: UIButton!
    @IBOutlet weak var phonNumberBtn: UIButton!
    @IBOutlet weak var hoursStackView: UIStackView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var heightOfContent: NSLayoutConstraint!
    @IBOutlet weak var phoneNumberBtnHeight: NSLayoutConstraint!
     @IBOutlet weak var websiteBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var upperofAddress2: NSLayoutConstraint!
    
    @IBOutlet weak var OpeningHStackW: NSLayoutConstraint!
    
    // add lable for daywise time.
    @IBOutlet weak var monTimeL: UILabel!
    @IBOutlet weak var tueTimeL: UILabel!
    @IBOutlet weak var wedTimeL: UILabel!
    @IBOutlet weak var thuTimeL: UILabel!
    @IBOutlet weak var friTimeL: UILabel!
    @IBOutlet weak var satTimeL: UILabel!
    @IBOutlet weak var sunTimeL: UILabel!
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var tit:String?
    var store:JSONStore?
    var cityName:String?
    var isFull = false
    var days = [String]()
    var lunchTimes = [String]()
    var dayNames = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    var delegate:UpdateFavorate?
    var indexPath:IndexPath?
    var tapGesture:UITapGestureRecognizer?
    let byAppointment = "by appointment"
    override func viewDidLoad() {
        super.viewDidLoad()
        // update navigation bar
        guard let height = navigationController?.navigationBar.frame.size.height else {return}
        
        let titleLabel = UILabel(frame: CGRect(x:0,y:0,width: 480,height: height))

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = tit
        titleLabel.font = UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        navigationItem.titleView = titleLabel
        self.navigationItem.title = tit
        navigationController!.navigationBar.isTranslucent = false
        
        // The navigation bar's shadowImage is set to a transparent image.  In
        // addition to providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        navigationController!.navigationBar.shadowImage = #imageLiteral(resourceName: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Pixel"), for: .default)
        
        navigationItem.prompt = ""
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        if self.navigationController!.viewControllers[0] === self
        {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross"), style: .plain, target: self, action: #selector(goBack))
        }
        else{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        }
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        let imageView = UIImageView(image: UIImage(named: self.getStoreTypeImage()))
        imageView.frame = CGRect.init(x: 0, y: 0, width: 24, height: 24) //CGRectMake(0, 0, 24, 24)
        let barButton = UIBarButtonItem.init(customView: imageView)
        self.navigationItem.rightBarButtonItem = barButton
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCloseTime))
        self.hoursStackView.addGestureRecognizer(tapGesture!)
        
        var city = ""
        if let cityNam = self.cityName{
           city = cityNam
        }
        else{
            print("no Cityname in cityname var")
        }
        if let cityNam = store?.cityName{
            if cityNam != ""{
                city = cityNam
            }
        }
        else {
            print("no Cityname in Store")
        }
       
        self.addressLable.text = (store?.address)!
        if city != ""{
            self.addressLable.text = self.addressLable.text! + "\n\(city)"
        }
        if store?.phone != "" {
            self.phonNumberBtn.setTitle(store?.phone, for: UIControlState.normal)
        }
        else{
            self.view.layoutIfNeeded()
            self.phoneNumberBtnHeight.constant = 0
            self.view.layoutIfNeeded()
        }
        
        if store?.address_2 != "" {
            self.view.layoutIfNeeded()
            upperofAddress2.constant = 2
            self.view.layoutIfNeeded()
        }
        configurePageControl()
        configureImageScroller()
        setTimelable()
        setLunchTime()
        setView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.descriptionLable.setContentOffset(CGPoint.zero, animated: false)
        for view in self.scrollView.subviews {
            view.frame.size.height = scrollView.frame.size.height
        }
        self.scrollView.contentSize.height = scrollView.frame.size.height
    }
    
    func setView()
    {
        if store!.on_holiday == "1" && isTodayHoliday()
        {
            self.contentOfScrollView.addConstraint(NSLayoutConstraint(item: self.contentOfScrollView, attribute:.trailing, relatedBy: .equal, toItem: self.hoursStackView, attribute: .trailing, multiplier: 1, constant: 8))
        }
        let attribute = [NSForegroundColorAttributeName:UIColor.black] as [String : Any]
        let buttonText = NSMutableAttributedString(string: self.removeHttp((store?.website)!), attributes: attribute)
        self.websiteLinkBtn.setAttributedTitle(buttonText, for: UIControlState.normal)
        if store?.website == "" {
            self.view.layoutIfNeeded()
            websiteBtnHeight.constant = 0
            self.view.layoutIfNeeded()
        }
        self.address2Lable.text = store?.address_2
        let htmlText = store?.descriptions
        if let htmlData = htmlText?.data(using: String.Encoding.unicode) {
            do {
                let attributedText = try NSMutableAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica Neue", size: 19)!, range: NSMakeRange(0,attributedText.length))
                let style = NSMutableParagraphStyle()
                style.lineSpacing = CGFloat(3.0)
                attributedText.addAttributes([NSParagraphStyleAttributeName : style], range: NSMakeRange(0,attributedText.length))
                self.descriptionLable.attributedText = attributedText
                
            } catch let e as NSError {
                print("Couldn't translate \(String(describing: htmlText)): \(e.localizedDescription) ")
            }
        }
        if CoreDataManager.sharedInstance().haveStore((store?.id)!){
            favorateBtn.isSelected = CoreDataManager.sharedInstance().getStore((store?.id)!).isFavorate
        }
        let catergoryString = getcatergories()
        let attributedText = NSMutableAttributedString(string: catergoryString)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = CGFloat(4.0)
        attributedText.addAttributes([NSParagraphStyleAttributeName : style], range: NSMakeRange(0,attributedText.length))
        categoriesLabel.attributedText = attributedText
        UIView.animate(withDuration: 0.01, animations: { () -> Void in
            self.leftStackView.isHidden = true
            self.rightStackView.isHidden = true
        }, completion: { (success) -> Void in
            self.leftStackView.removeFromSuperview()
            self.rightStackView.removeFromSuperview()
            self.isFull = false
        })

        self.shareBtn.addBorder(width: 2)
        self.showOnMapBtn.addBorder(width: 2)
        self.favorateBtn.addBorder(width: 2)
        addBtnOnStackV()
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        if getImageUrlArray().count == 1
        {
            self.pageControl.numberOfPages = 0
        }
        else{
            self.pageControl.numberOfPages = getImageUrlArray().count
        }
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
    }
    
    func configureImageScroller()
    {
        scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        let imageUrls = getImageUrlArray()
        
        for index in 0..<imageUrls.count{
            
            frame.origin.x = self.view.frame.size.width * CGFloat(index)
            frame.size.height = self.view.frame.size.height*10/25
            frame.size.width = self.view.frame.size.width
            self.scrollView.isPagingEnabled = true
            let imageV = UIImageView(frame: frame)
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            let url = URL(string:imageUrls[index])!
            imageV.af_setImage(withURL: url, placeholderImage: UIImage(named: "placeholder"), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
            self.scrollView.addSubview(imageV)
        }
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(imageUrls.count), height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(changePage), for: UIControlEvents.valueChanged)
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(_ sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * view.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    // MARK - Btn Action methods
    func goBack(_ sender:AnyObject) -> ()
    {
        if self.navigationController!.viewControllers[0] === self{
            self.navigationController!.dismiss(animated: true, completion: nil)
        }
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func showOnMapAction(_ sender: Any) {
        var stores = [JSONStore]()
        stores.append(self.store!)
        let next = self.storyboard?.instantiateViewController(withIdentifier:"MyMapVC") as! MyMapVC
        next.tit = store?.name
        next.stores = stores
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        let comma = ","
        if store?.cityName == "" {
            BookCitiesClient.sharedInstance().getCityOrigin([String : AnyObject](),id:(store?.city)!,completionHandlerForCityOrigin:{
                (response,error)in
                let city = JSONState.stateFromResults(response?["cities"] as! [[String : AnyObject]])
                self.store?.cityName = city[0].name
                let storeName = (self.store?.name)!
                let cityName = (self.store?.cityName)!
                let link = (self.store?.website)!
                // set up activity view controller
                let textToShare = [storeName+": "+link] as [Any]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.setValue(storeName+comma+" "+cityName, forKey: "subject")
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
            })
        }
        else{
            let storeName = (self.store?.name)!
            let cityName = (self.store?.cityName)!
            let link = (self.store?.website)!
            // set up activity view controller
            let textToShare = [storeName+": "+link] as [Any]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.setValue(storeName+comma+" "+cityName, forKey: "subject")
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func favorateAction(_ sender: Any) {
        if favorateBtn.isSelected
        {
            favorateBtn.isSelected = false
            store?.isFavorate = false
            CoreDataManager.sharedInstance().deleteStore(storeID: (self.store?.id)!)
            self.delegate?.updateTableView(indexpath: indexPath!)
        }
        else{
            favorateBtn.isSelected = true
            store?.isFavorate = true
            BookCitiesClient.sharedInstance().getCityOrigin([String : AnyObject](),id:(store?.city)!,completionHandlerForCityOrigin:{
                (response,error)in
                let city = JSONState.stateFromResults(response?["cities"] as! [[String : AnyObject]])
                CoreDataManager.sharedInstance().saveStores(self.store!,cityName: city[0].name)
                 self.delegate?.updateTableViewOnly()
            })
        }
        
    }
    
    @IBAction func websiteLinkBtnAction(_ sender: Any) {
        let url = URL(string: (store?.website)!)
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        else {
            let alert = UIAlertController(title: Constants.Alert.TitleNotAWebLink, message: (store?.website)! + "  is not the valid url", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func phonNumberBtnAction(_ sender: Any) {
        if let number = store?.phone {
            let num = getcorrectPhoneNumber(number: number)
            if UIApplication.shared.canOpenURL(URL(string: "telprompt://"+num)!){
                UIApplication.shared.open(URL(string: "telprompt://"+num)!, options: [:], completionHandler: nil)
            }
            
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
    
    // MARK: - get the image according to the type of store
    func getStoreTypeImage()->String{
        if store!.is_new_books == "1" && (store!.is_used_books == "1") && (store!.is_museumshops == "1")
        {
            return ""
        }
        else if store!.is_new_books == "0" && (store!.is_used_books == "1") && (store!.is_museumshops == "1")
        {
            return Constants.image.GreenBlueCircle
        }
        else if store!.is_new_books == "1" && (store!.is_used_books == "0") && (store!.is_museumshops == "1")
        {
            return Constants.image.RedGreenCircle
        }
        else if store!.is_new_books == "1" && (store!.is_used_books == "1") && (store!.is_museumshops == "0")
        {
            return Constants.image.BlueRedCircle
        }
        else if store!.is_new_books == "0" && (store!.is_used_books == "0") && (store!.is_museumshops == "1"){
            return Constants.image.GreenCircle
        }
        else if store!.is_new_books == "1" && (store!.is_used_books == "0") && (store!.is_museumshops == "0"){
            return Constants.image.RedCircle
        }
        else if store!.is_new_books == "0" && (store!.is_used_books == "1") && (store!.is_museumshops == "0"){
            return Constants.image.BlueCircle
        }
        else {
            return ""
        }
    }
    
    
    func getImageUrlArray () -> Array<String>
    {
        let path  = Constants.image.ImagePath
        var array = [String]()
        if store?.image1 != path{
            array.append((store?.image1)!)
        }
        if store?.image2 != path{
            array.append((store?.image2)!)
        }
        if store?.image3 != path{
            array.append((store?.image3)!)
        }
        if store?.image4 != path{
            array.append((store?.image4)!)
        }
        return array
    }
    
    func getcatergories() ->String
    {
        let categoryIds = store?.books_category_ids
        var categoryString = ""
        let catergoryArray = categoryIds?.characters.split{$0 == ":"}.map(String.init)
        for value in catergoryArray!{
            categoryString.append(CoreDataManager.sharedInstance().getCategoryName(id: value)+", ")
        }
        if categoryString != "" {
            categoryString = categoryString.substring(to: categoryString.index(before: categoryString.index(before: categoryString.endIndex)))
            return categoryString
        }
        else{
            return ""
        }
    }
    
    func setTimelable()
    {
            if store!.sun_by_appointment != "1" {
                sunTimeL.text = getString(fromHr: (store?.sun_from_hr)!, fromMin: (store?.sun_from_mins)!, toHr: (store?.sun_to_hr)!, toMin: (store?.sun_to_mins)!)
                days.append(sunTimeL.text!)
            }
            else{
                sunTimeL.text = byAppointment
                days.append(sunTimeL.text!)
            }
            if store!.mon_by_appointment != "1" {
                monTimeL.text = getString(fromHr: (store?.mon_from_hr)!, fromMin: (store?.mon_from_mins)!, toHr: (store?.mon_to_hr)!, toMin: (store?.mon_to_mins)!)
                days.append(monTimeL.text!)
                
            }
            else{
                monTimeL.text = byAppointment
                days.append(monTimeL.text!)
            }
            if store!.tue_by_appointment != "1" {
                tueTimeL.text = getString(fromHr: (store?.tue_from_hr)!, fromMin: (store?.tue_from_mins)!, toHr: (store?.tue_to_hr)!, toMin: (store?.tue_to_mins)!)
                days.append(tueTimeL.text!)
            }
            else{
                tueTimeL.text = byAppointment
                days.append(tueTimeL.text!)
            }
            if store!.wed_by_appointment != "1" {
                wedTimeL.text = getString(fromHr: (store?.wed_from_hr)!, fromMin: (store?.wed_from_mins)!, toHr: (store?.wed_to_hr)!, toMin: (store?.wed_to_mins)!)
                days.append(wedTimeL.text!)
            }
            else{
                wedTimeL.text = byAppointment
                days.append(wedTimeL.text!)
            }
            if store!.thurs_by_appointment != "1" {
                thuTimeL.text = getString(fromHr: (store?.thurs_from_hr)!, fromMin: (store?.thurs_from_mins)!, toHr: (store?.thurs_to_hr)!, toMin: (store?.thurs_to_mins)!)
                days.append(thuTimeL.text!)
            }
            else{
                thuTimeL.text = byAppointment
                days.append(thuTimeL.text!)
            }
            if store!.fri_by_appointment != "1" {
                friTimeL.text = getString(fromHr: (store?.fri_from_hr)!, fromMin: (store?.fri_from_mins)!, toHr: (store?.fri_to_hr)!, toMin: (store?.fri_to_mins)!)
                days.append(friTimeL.text!)        }
            else{
                friTimeL.text = byAppointment
                days.append(friTimeL.text!)
            }
            if store!.sat_by_appointment != "1" {
                satTimeL.text = getString(fromHr: (store?.sat_from_hr)!, fromMin: (store?.sat_from_mins)!, toHr: (store?.sat_to_hr)!, toMin: (store?.sat_to_mins)!)
                days.append(satTimeL.text!)
            }
            else{
                satTimeL.text = byAppointment
                days.append(satTimeL.text!)
            }
        
    }
    
    func setLunchTime()
    {
        if store!.sun_by_appointment != "1" {
            sunTimeL.text = getString(fromHr: (store?.sun_lunch_from_hr)!, fromMin: (store?.sun_lunch_from_mins)!, toHr: (store?.sun_lunch_to_hr)!, toMin: (store?.sun_lunch_to_mins)!)
            lunchTimes.append(sunTimeL.text!)
        }
        else{
            sunTimeL.text = byAppointment
            lunchTimes.append(sunTimeL.text!)
        }
        if store!.mon_by_appointment != "1" {
            monTimeL.text = getString(fromHr: (store?.mon_lunch_from_hr)!, fromMin: (store?.mon_lunch_from_mins)!, toHr: (store?.mon_lunch_to_hr)!, toMin: (store?.mon_lunch_to_mins)!)
            lunchTimes.append(monTimeL.text!)
            
        }
        else{
            monTimeL.text = byAppointment
            lunchTimes.append(monTimeL.text!)
        }
        if store!.tue_by_appointment != "1" {
            tueTimeL.text = getString(fromHr: (store?.tue_lunch_from_hr)!, fromMin: (store?.tue_lunch_from_mins)!, toHr: (store?.tue_lunch_to_hr)!, toMin: (store?.tue_lunch_to_mins)!)
            lunchTimes.append(tueTimeL.text!)
        }
        else{
            tueTimeL.text = byAppointment
            lunchTimes.append(tueTimeL.text!)
        }
        if store!.wed_by_appointment != "1" {
            wedTimeL.text = getString(fromHr: (store?.wed_lunch_from_hr)!, fromMin: (store?.wed_lunch_from_mins)!, toHr: (store?.wed_lunch_to_hr)!, toMin: (store?.wed_lunch_to_mins)!)
            lunchTimes.append(wedTimeL.text!)
        }
        else{
            wedTimeL.text = byAppointment
            lunchTimes.append(wedTimeL.text!)
        }
        if store!.thurs_by_appointment != "1" {
            thuTimeL.text = getString(fromHr: (store?.thurs_lunch_from_hr)!, fromMin: (store?.thurs_lunch_from_mins)!, toHr: (store?.thurs_lunch_to_hr)!, toMin: (store?.thurs_lunch_to_mins)!)
            lunchTimes.append(thuTimeL.text!)
        }
        else{
            thuTimeL.text = byAppointment
            lunchTimes.append(thuTimeL.text!)
        }
        if store!.fri_by_appointment != "1" {
            friTimeL.text = getString(fromHr: (store?.fri_lunch_from_hr)!, fromMin: (store?.fri_lunch_from_mins)!, toHr: (store?.fri_lunch_to_hr)!, toMin: (store?.fri_lunch_to_mins)!)
            lunchTimes.append(friTimeL.text!)        }
        else{
            friTimeL.text = byAppointment
            lunchTimes.append(friTimeL.text!)
        }
        if store!.sat_by_appointment != "1" {
            satTimeL.text = getString(fromHr: (store?.sat_lunch_from_hr)!, fromMin: (store?.sat_lunch_from_mins)!, toHr: (store?.sat_lunch_to_hr)!, toMin: (store?.sat_lunch_to_mins)!)
            lunchTimes.append(satTimeL.text!)
        }
        else{
            satTimeL.text = byAppointment
            lunchTimes.append(satTimeL.text!)
        }
    }
    
    func getString(fromHr:String,fromMin:String,toHr:String,toMin:String) ->String
    {
        var fromhr = fromHr
        var frommin = fromMin
        var tohr = toHr
        var tomin = toMin
        
        if fromHr == "0"&&toHr == "0" && fromMin == "0" && toMin == "0"
        {
            return "closed"
        }
        if Int(frommin)! < 10 {
            frommin = "0"+frommin
        }
        if Int(fromhr)! < 10 {
            fromhr = "0"+fromhr
        }
        if Int(tomin)! < 10 {
            tomin = "0"+tomin
        }
        if Int(tohr)! < 10 {
            tohr = "0"+tohr
        }
        return fromhr+":"+frommin+" - "+tohr+":"+tomin
    }
    
    func getcorrectPhoneNumber(number:String) ->String
    {
        var no = number.trimmingCharacters(in: .whitespaces)
        if no.contains(" ")
        {
            no = no.replacingOccurrences(of: " ", with: "")
            
        }
        return no
    }
    // add Open Button On StackView
    func addBtnOnStackV(){
        deleteStackView()
        let stack = self.hoursStackView
        let index = (stack?.arrangedSubviews.count)! - 1
        let newView = createEntry()
        newView.isHidden = true
        stack?.insertArrangedSubview(newView, at: index)
        
        UIView.animate(withDuration: 0.01) { () -> Void in
            newView.isHidden = false
        }
    }
    
    func createEntry() ->UIView{
        if store!.on_holiday == "1" && isTodayHoliday()
        {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 2.0
            let textforTime = (store?.holiday_message)!
            let timeInWordlable = UILabel()
            timeInWordlable.numberOfLines = 0
            timeInWordlable.text = textforTime
            timeInWordlable.font = UIFont.systemFont(ofSize: 19)
            let arrowButton = UIButton(type: .roundedRect)
            arrowButton.setImage(UIImage(named: "downArrow")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),for: .normal)
            arrowButton.contentVerticalAlignment = .top
            arrowButton.contentHorizontalAlignment = .right
//            arrowButton.setTitle("", for: .normal)
            arrowButton.addTarget(self, action:#selector(showFullTime(sender:)), for: .touchUpInside)
//            arrowButton.setContentCompressionResistancePriority(1000, for: UILayoutConstraintAxis.horizontal);
            stack.addArrangedSubview(timeInWordlable)
            stack.addArrangedSubview(arrowButton)
            return stack
        }
        else{
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .firstBaseline
            stack.distribution = .fillProportionally
            stack.spacing = 8.0
            var textforTime = ""
            let timeInNumber = UILabel()
            if isByAppoinment(){
                textforTime = byAppointment
            }
            else{
                if isOpen() {
                    if isLunchBreak() {
                        textforTime = "Lunch Break"
                    }
                    else{
                        textforTime = "Open now"
                        let date = Date()
                        let calendar = NSCalendar.current
                        let components = calendar.component(.weekday, from: date)
                        let day = Int(components.description)! - 1
                        timeInNumber.text = days[Int(day)]
                    }
                }
                else{
                    textforTime = "closed"
                }
            }
            let timeInWordlable = UILabel()
            timeInWordlable.text = textforTime
            timeInWordlable.font = UIFont.systemFont(ofSize: 19)
            timeInNumber.font = UIFont.systemFont(ofSize: 19)
            let arrowButton = UIButton(type: .roundedRect)
            arrowButton.setImage(UIImage(named: "downArrow")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),for: .normal)
            arrowButton.setTitle("", for: .normal)
            arrowButton.addTarget(self, action:#selector(showFullTime(sender:)), for: .touchUpInside)
            stack.addArrangedSubview(timeInWordlable)
            if (timeInNumber.text != nil){
                stack.addArrangedSubview(timeInNumber)
            }
            stack.addArrangedSubview(arrowButton)
            
            return stack
        }
    }
    
    func showFullTime(sender:UIButton){
        self.openCloseTime()
    }
    
    func deleteStackView()
    {
        let stack = self.hoursStackView
        let index = (stack?.arrangedSubviews.count)! - 1
        if let view = stack?.arrangedSubviews[index] {
            UIView.animate(withDuration: 0.01, animations: { () -> Void in
                view.isHidden = true
            }, completion: { (success) -> Void in
                view.removeFromSuperview()
            })
        }
    }
    
    func openCloseTime()
    {
        if isFull {
            addBtnOnStackV()
            isFull = false
        }
        else{
            isFull = true
            let stack = self.hoursStackView
            let index = (stack?.arrangedSubviews.count)! - 1
            let addView = stack?.arrangedSubviews[index]
            addView?.removeFromSuperview()
            
            UIView.animate(withDuration: 0.01, animations: { () -> Void in
                addView?.isHidden = true
            }, completion: { (success) -> Void in
                addView?.removeFromSuperview()
                self.addStacks()
            })
        }
    }
    
    func addStacks()
    {
        let stack = self.hoursStackView
        let newView = createFullStack()
        
        newView.isHidden = true
        stack?.addArrangedSubview(newView)
        UIView.animate(withDuration: 0.01) { () -> Void in
            newView.isHidden = false
        }
        
    }
    
    func createFullStack() -> UIView{
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 2
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.component(.weekday, from: date)
        let d = Int(components.description)! - 1
        
        for day in d ..< 7 {
            if lunchTimes[day] != "closed"
            {
                stack.addArrangedSubview(createStack(day: dayNames[day], time: "\(days[day]) / \(lunchTimes[day])"))
            }
            else{
                stack.addArrangedSubview(createStack(day: dayNames[day], time:days[day]))
            }
        }
        for day in 0 ..< d {
            if lunchTimes[day] != "closed"
            {
                stack.addArrangedSubview(createStack(day: dayNames[day], time: "\(days[day]) / \(lunchTimes[day])"))
            }
            else{
                stack.addArrangedSubview(createStack(day: dayNames[day], time:days[day]))
            }
        }
        for i in 0 ..< 6 {
            let view0:UIStackView = stack.arrangedSubviews[i] as! UIStackView
            let view00 = view0.arrangedSubviews[0]
            let view4:UIStackView = stack.arrangedSubviews[i+1] as! UIStackView
            let view40 = view4.arrangedSubviews[0]
            let width = NSLayoutConstraint(item: view00, attribute: .width, relatedBy: .equal, toItem: view40, attribute: .width, multiplier: 1.0, constant: 0)
            stack.addConstraint(width)
        }
        return stack
    }
    
    func createStack(day:String,time:String) ->UIStackView
    {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.distribution = .equalSpacing
        stack.spacing = 8
        
        let timeInWordlable = UILabel()
        timeInWordlable.text = day
        timeInWordlable.textAlignment = .left
        timeInWordlable.font = UIFont.systemFont(ofSize: 19)
        
        let timeInNumber = UILabel()
        timeInNumber.text = time
        timeInNumber.textAlignment = .left
        timeInNumber.font = UIFont.systemFont(ofSize: 19)
        
        stack.addArrangedSubview(timeInWordlable)
        stack.addArrangedSubview(timeInNumber)
        
        return stack
    }
    
    func isOpen() -> Bool
    {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.component(.weekday, from: date)
        let day = Int(components.description)! - 1
        if days[Int(day)] == "closed"
        {
            return false
        }
        else{
            let hour = calendar.component(.hour, from: date as Date)
            let minutes = calendar.component(.minute, from: date as Date)
            let currentTime = hour * 60 + minutes
//            print("current - > \(currentTime)")
            var time = days[Int(day)] as String
            time = time.trimmingCharacters(in: .whitespaces)
            let times = time.characters.split{$0 == "-"}.map(String.init)
            
            var uppertime = times[0].characters.split(separator: ":").map(String.init)
            var lowertime = times[1].characters.split(separator: ":").map(String.init)
            uppertime[0] = uppertime[0].trimmingCharacters(in: .whitespaces)
            uppertime[1] = uppertime[1].trimmingCharacters(in: .whitespaces)
            lowertime[0] = lowertime[0].trimmingCharacters(in: .whitespaces)
            lowertime[1] = lowertime[1].trimmingCharacters(in: .whitespaces)
            
            var upper = 0
            var lower = 23
            
            if let upperLimit = Int(uppertime[0]){
                upper = upperLimit * 60 + Int(uppertime[1])!
            }
            if let lowerLimit = Int(lowertime[0]) {
                if Int(uppertime[0])! > lowerLimit {
                    lower = lowerLimit * 60 + Int(lowertime[1])!
                    if currentTime < lower || currentTime > upper {
                        return true
                    }
                    lower = (lowerLimit + 24) * 60 + Int(lowertime[1])!
                }
                else{
                    lower = lowerLimit * 60 + Int(lowertime[1])!
                }
            }

            if upper < currentTime && lower > currentTime {
                return true
            }
            else{
                return false
            }
        }
    }
    
    func isByAppoinment() -> Bool
    {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.component(.weekday, from: date)
        let day = Int(components.description)! - 1
        if days[Int(day)] == byAppointment
        {
            return true
        }
        else{
            return false
        }
    }
    
    func removeHttp(_ webLink:String) ->String{
        var weblink = webLink
        if webLink.contains("https://")
        {
           weblink = webLink.replacingOccurrences(of: "https://", with: "")
        }
        if webLink.contains("http://")
        {
            weblink = webLink.replacingOccurrences(of: "http://", with: "")
        }
        return weblink
    }
    
    func isTodayHoliday() -> Bool
    {
        let currentDate = Date()
        let startDate = Date(timeIntervalSince1970: Double(store!.holiday_from!)!)
        let endDate = Date(timeIntervalSince1970: Double(store!.holiday_to!)!)
        if currentDate >= startDate && currentDate <= endDate
        {
            return true
        }
        return false
    }
    
    func isLunchBreak() -> Bool {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.component(.weekday, from: date)
        let day = Int(components.description)! - 1
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        let currentTime = hour * 60 + minutes
        print("current -------------------------------->>>>>>>>>>>> \(currentTime)")
        var time = lunchTimes[Int(day)] as String
        if time == "closed"{
            return false
        }
        time = time.trimmingCharacters(in: .whitespaces)
        let times = time.characters.split{$0 == "-"}.map(String.init)
        
        var uppertime = times[0].characters.split(separator: ":").map(String.init)
        var lowertime = times[1].characters.split(separator: ":").map(String.init)
        uppertime[0] = uppertime[0].trimmingCharacters(in: .whitespaces)
        uppertime[1] = uppertime[1].trimmingCharacters(in: .whitespaces)
        lowertime[0] = lowertime[0].trimmingCharacters(in: .whitespaces)
        lowertime[1] = lowertime[1].trimmingCharacters(in: .whitespaces)
        
        var upper = 0
        var lower = 23
        
        if let upperLimit = Int(uppertime[0]){
            upper = upperLimit * 60 + Int(uppertime[1])!
        }
        if let lowerLimit = Int(lowertime[0]) {
            if Int(uppertime[0])! > lowerLimit {
                lower = lowerLimit * 60 + Int(lowertime[1])!
                if currentTime < lower || currentTime > upper {
                    return true
                }
                lower = (lowerLimit + 24) * 60 + Int(lowertime[1])!
            }
            else{
                lower = lowerLimit * 60 + Int(lowertime[1])!
            }
        }
        
        if upper < currentTime && lower > currentTime {
            return true
        }
        else{
            return false
        }
    }
}
extension ShopDetailVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
