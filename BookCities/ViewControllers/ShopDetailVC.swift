//
//  ShopDetailVC.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/14/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit

class ShopDetailVC: UIViewController , UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var favorateBtn: BorderButton!
    @IBOutlet weak var shareBtn: BorderButton!
    @IBOutlet weak var showOnMapBtn: BorderButton!
   
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
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
        configurePageControl()
        configureImageScroller()
        
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
    }
    
    func configureImageScroller()
    {
        scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        for index in 0..<4 {
            
            frame.origin.x = self.view.frame.size.width * CGFloat(index)
            
            frame.size.height = self.view.frame.size.height*10/25
            frame.size.width = self.view.frame.size.width
            self.scrollView.isPagingEnabled = true
            
            let imageV = UIImageView(frame: frame)
            imageV.image = UIImage(named: "logo")
            imageV.backgroundColor = colors[index]
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
        
    }
    @IBAction func shareBtnAction(_ sender: Any) {
        
    }
    @IBAction func favorateAction(_ sender: Any) {
        if favorateBtn.isSelected
        {
            favorateBtn.isSelected = false
        }
        else{
            favorateBtn.isSelected = true
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

}
