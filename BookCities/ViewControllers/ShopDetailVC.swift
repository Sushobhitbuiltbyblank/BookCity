//
//  ShopDetailVC.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/14/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import AlamofireImage
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
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var contentOfScrollView: UIView!
    @IBOutlet weak var websiteLinkBtn: UIButton!
    
   
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: self.getStoreTypeImage())?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.addressLable.text = store?.address
        configurePageControl()
        configureImageScroller()
        setTimelable()
        setView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.descriptionTV.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func setView()
    {
        let attribute = [NSUnderlineStyleAttributeName:1,
                         NSForegroundColorAttributeName:UIColor.black] as [String : Any]
        let buttonText = NSMutableAttributedString(string: (store?.website)!, attributes: attribute)
        self.websiteLinkBtn.setAttributedTitle(buttonText, for: UIControlState.normal)
        self.websiteLinkBtn.titleLabel?.text = store?.website
        self.address2Lable.text = store?.address_2
        let htmlText = store?.descriptions
        if let htmlData = htmlText?.data(using: String.Encoding.unicode) {
            do {
                let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                self.descriptionTV.attributedText = attributedText
            } catch let e as NSError {
                print("Couldn't translate \(htmlText): \(e.localizedDescription) ")
            }
        }
        favorateBtn.isSelected = (store?.isFavorate)!
        self.categoryLable.text = getcatergories()
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = 4
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
        for index in 0..<4 {
            
            frame.origin.x = self.view.frame.size.width * CGFloat(index)
            frame.size.height = self.view.frame.size.height*10/25
            frame.size.width = self.view.frame.size.width
            self.scrollView.isPagingEnabled = true
            let imageV = UIImageView(frame: frame)
            let url = URL(string:imageUrls[index])!
            imageV.af_setImage(withURL: url, placeholderImage: UIImage(named: "placeholder"), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
            self.scrollView.addSubview(imageV)
        }
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 4, height: self.scrollView.frame.size.height)
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
        
        let header = store?.name
        let gap = "\n"
        let link = "Link - "+(store?.website)!
        let address = "Address - "+(store?.address)!
        let phone = "Contact - "+(store?.phone)!
        let categories = "Catergory - "+getcatergories()
        // set up activity view controller
        let textToShare = [header!,link,gap,phone,gap,address,gap,categories] as [Any]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func favorateAction(_ sender: Any) {
        if favorateBtn.isSelected
        {
            favorateBtn.isSelected = false
            store?.isFavorate = false
            CoreDataManager.sharedInstance().deleteStore(storeID: (self.store?.id)!)
        }
        else{
            favorateBtn.isSelected = true
            store?.isFavorate = true
            BookCitiesClient.sharedInstance().getCityOrigin([String : AnyObject](),id:(store?.city)!,completionHandlerForCityOrigin:{
                (response,error)in
                    let city = JSONState.stateFromResults(response?["cities"] as! [[String : AnyObject]])
                    print(city[0].name)
                    CoreDataManager.sharedInstance().saveStores(self.store!,cityName: city[0].name)
            })
        }

    }
    
    @IBAction func websiteLinkBtnAction(_ sender: Any) {
        let url = URL(string: (store?.website)!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
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
        let image1:String = store?.image1 ?? ""
        let image2:String = store?.image2 ?? ""
        let image3:String = store?.image3 ?? ""
        let image4:String = store?.image4 ?? ""
        
        let array = [image1,image2,image3,image4]
        return array 
    }
    
    func getcatergories() ->String
    {
        let categoryIds = store?.books_category_ids
        var categoryString = ""
        let catergoryArray = categoryIds?.characters.split{$0 == ":"}.map(String.init)
        for value in catergoryArray!{
            categoryString.append(CoreDataManager.sharedInstance().getCategoryName(id: value)+",")
        }
        if categoryString != "" {
            categoryString = categoryString.substring(to: categoryString.index(before: categoryString.endIndex))
            return categoryString
        }
        else{
            return ""
        }
    }
    
    func setTimelable()
    {
        monTimeL.text = getString(fromHr: (store?.mon_from_hr)!, fromMin: (store?.mon_from_mins)!, toHr: (store?.mon_to_hr)!, toMin: (store?.mon_to_mins)!)
        tueTimeL.text = getString(fromHr: (store?.tue_from_hr)!, fromMin: (store?.tue_from_mins)!, toHr: (store?.tue_to_hr)!, toMin: (store?.tue_to_mins)!)
        tueTimeL.text = getString(fromHr: (store?.tue_from_hr)!, fromMin: (store?.tue_from_mins)!, toHr: (store?.tue_to_hr)!, toMin: (store?.tue_to_mins)!)
        wedTimeL.text = getString(fromHr: (store?.wed_from_hr)!, fromMin: (store?.wed_from_mins)!, toHr: (store?.wed_to_hr)!, toMin: (store?.wed_to_mins)!)
        thuTimeL.text = getString(fromHr: (store?.thurs_from_hr)!, fromMin: (store?.thurs_from_mins)!, toHr: (store?.thurs_to_hr)!, toMin: (store?.thurs_to_mins)!)
        friTimeL.text = getString(fromHr: (store?.fri_from_hr)!, fromMin: (store?.fri_from_mins)!, toHr: (store?.fri_to_hr)!, toMin: (store?.fri_to_mins)!)
        satTimeL.text = getString(fromHr: (store?.sat_from_hr)!, fromMin: (store?.sat_from_mins)!, toHr: (store?.sat_to_hr)!, toMin: (store?.sat_to_mins)!)
        sunTimeL.text = getString(fromHr: (store?.sun_from_hr)!, fromMin: (store?.sun_from_mins)!, toHr: (store?.sun_to_hr)!, toMin: (store?.sun_to_mins)!)
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
        if fromMin == "0"{
                frommin = "00"
            }
            if fromHr == "0"{
                fromhr = "00"
            }
            if toMin == "0"{
                tomin = "00"
            }
            if toHr == "00"{
                tohr = "0"
            }
        return fromhr+":"+frommin+" - "+tohr+":"+tomin
    }
    
}
