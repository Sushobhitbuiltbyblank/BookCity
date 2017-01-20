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
    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var address2Lable: UILabel!
//    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var contentOfScrollView: UIView!
    @IBOutlet weak var websiteLinkBtn: UIButton!
    @IBOutlet weak var phonNumberBtn: UIButton!
    @IBOutlet weak var hoursStackView: UIStackView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var heightOfContent: NSLayoutConstraint!
    
    
    
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
    var dayNames = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    var delegate:UpdateFavorate?
    var indexPath:IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        // update navigation bar
        self.navigationItem.title = tit
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        let imageView = UIImageView(image: UIImage(named: self.getStoreTypeImage()))
        imageView.frame = CGRect.init(x: 0, y: 0, width: 24, height: 24) //CGRectMake(0, 0, 24, 24)
        let barButton = UIBarButtonItem.init(customView: imageView)
        self.navigationItem.rightBarButtonItem = barButton
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: self.getStoreTypeImage())?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: nil, action: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCloseTime))
        self.hoursStackView.addGestureRecognizer(tapGesture)
        
        self.addressLable.text = (store?.address)!
        self.phonNumberBtn.setTitle(store?.phone, for: UIControlState.normal)
        configurePageControl()
        configureImageScroller()
        setTimelable()
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
        let attribute = [NSForegroundColorAttributeName:UIColor.black] as [String : Any]
        let buttonText = NSMutableAttributedString(string: self.removeHttp((store?.website)!), attributes: attribute)
        self.websiteLinkBtn.setAttributedTitle(buttonText, for: UIControlState.normal)
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
                print("Couldn't translate \(htmlText): \(e.localizedDescription) ")
            }
        }
        if CoreDataManager.sharedInstance().haveStore((store?.id)!){
            favorateBtn.isSelected = CoreDataManager.sharedInstance().getStore((store?.id)!).isFavorate
        }
        self.categoryLable.text = getcatergories()
        
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
//        self.shareBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 26, 12, 26)
//        self.shareBtn.imageView?.contentMode = .scaleAspectFit
//        self.favorateBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 26, 12, 26)
//        self.favorateBtn.imageView?.contentMode = .scaleAspectFit
        navigationController!.navigationBar.isTranslucent = false
        
        // The navigation bar's shadowImage is set to a transparent image.  In
        // addition to providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        navigationController!.navigationBar.shadowImage = #imageLiteral(resourceName: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Pixel"), for: .default)

        navigationItem.prompt = ""
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
                activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
                
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
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            
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
                 self.delegate?.updateTableView(indexpath: self.indexPath!)
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
        sunTimeL.text = getString(fromHr: (store?.sun_from_hr)!, fromMin: (store?.sun_from_mins)!, toHr: (store?.sun_to_hr)!, toMin: (store?.sun_to_mins)!)
        days.append(sunTimeL.text!)
        monTimeL.text = getString(fromHr: (store?.mon_from_hr)!, fromMin: (store?.mon_from_mins)!, toHr: (store?.mon_to_hr)!, toMin: (store?.mon_to_mins)!)
        days.append(monTimeL.text!)
        tueTimeL.text = getString(fromHr: (store?.tue_from_hr)!, fromMin: (store?.tue_from_mins)!, toHr: (store?.tue_to_hr)!, toMin: (store?.tue_to_mins)!)
        days.append(tueTimeL.text!)
        wedTimeL.text = getString(fromHr: (store?.wed_from_hr)!, fromMin: (store?.wed_from_mins)!, toHr: (store?.wed_to_hr)!, toMin: (store?.wed_to_mins)!)
        days.append(wedTimeL.text!)
        thuTimeL.text = getString(fromHr: (store?.thurs_from_hr)!, fromMin: (store?.thurs_from_mins)!, toHr: (store?.thurs_to_hr)!, toMin: (store?.thurs_to_mins)!)
        days.append(thuTimeL.text!)
        friTimeL.text = getString(fromHr: (store?.fri_from_hr)!, fromMin: (store?.fri_from_mins)!, toHr: (store?.fri_to_hr)!, toMin: (store?.fri_to_mins)!)
        days.append(friTimeL.text!)
        satTimeL.text = getString(fromHr: (store?.sat_from_hr)!, fromMin: (store?.sat_from_mins)!, toHr: (store?.sat_to_hr)!, toMin: (store?.sat_to_mins)!)
        days.append(satTimeL.text!)
        
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
        
//        if no.contains("(")
//        {
//            no = no.replacingOccurrences(of: "(", with: "")
//
//        }
        
        if no.contains(" ")
        {
            no = no.replacingOccurrences(of: " ", with: "")
            
        }
        
//        if no.contains(")")
//        {
//            no = no.replacingOccurrences(of: ")", with: "")
//        }
        
//        if no.contains("+") {
//            no = no.replacingOccurrences(of: "+", with: "")
//        }
        
//        if no.contains("-")
//        {
//            no = no.replacingOccurrences(of: "-", with: "")
//        }
        
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
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.distribution = .fillProportionally
        stack.spacing = 8.0
        var textforTime = ""
        let timeInNumber = UILabel()
        if isOpen() {
            textforTime = "Open now"
            let date = Date()
            let calendar = NSCalendar.current
            let components = calendar.component(.weekday, from: date)
            let day = Int(components.description)! - 1
            
            timeInNumber.text = days[Int(day)]
        }
        else{
            textforTime = "closed"
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
        stack.addArrangedSubview(timeInNumber)
        stack.addArrangedSubview(arrowButton)
        
        return stack
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
            stack.addArrangedSubview(createStack(day: dayNames[day], time: days[day]))
        }
        for day in 0 ..< d {
            stack.addArrangedSubview(createStack(day: dayNames[day], time: days[day]))
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
//                print("upper -> \(upper)")
            }
            if let lowerLimit = Int(lowertime[0]) {
                if Int(uppertime[0])! > lowerLimit {
                    lower = lowerLimit * 60 + Int(lowertime[1])!
//                    print("lower -> \(lower)")
                    if currentTime < lower || currentTime > upper {
                        return true
                    }
                    lower = (lowerLimit + 24) * 60 + Int(lowertime[1])!
                }
                else{
                    lower = lowerLimit * 60 + Int(lowertime[1])!
                }
//                print("lower -> \(lower)")
            }

            if upper < currentTime && lower > currentTime {
                return true
            }
            else{
                return false
            }
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
}
