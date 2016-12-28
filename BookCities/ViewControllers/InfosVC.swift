//
//  InfosVC.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/8/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import PKHUD
class InfosVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar Update
        self.navigationItem.title = "Infos"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont(name: Constants.Font.TypeHelvetica, size: CGFloat(Constants.Font.Size))!
        ]
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 248/255, green: 8/255, blue: 8/255, alpha: 0.5)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "cross")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(closeBtnAction))
        HUD.show(.progress)
        BookCitiesClient.sharedInstance().getInfoData([:], {
            (response,error) in
            let htmlText = response
            if let htmlData = htmlText?.data(using: String.Encoding.unicode) {
                do {
                    let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                    HUD.hide()
                    self.textView.attributedText = attributedText
                } catch let e as NSError {
                    print("Couldn't translate \(htmlText): \(e.localizedDescription) ")
                }
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
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
