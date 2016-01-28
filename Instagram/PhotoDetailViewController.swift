//
//  PhotoDetailViewController.swift
//  Instagram
//
//  Created by Dhiman on 1/28/16.
//  Copyright © 2016 Dhiman. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    var PhotoUrl : String!

    @IBOutlet weak var Imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Imageview.setImageWithURL(NSURL(string: PhotoUrl)!)
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
