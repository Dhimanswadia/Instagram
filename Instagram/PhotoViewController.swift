//
//  PhotoViewController.swift
//  Instagram
//
//  Created by Dhiman on 1/21/16.
//  Copyright © 2016 Dhiman. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var Photos : [NSDictionary] = []
    let HeaderViewIdentifier = "TableViewHeaderView"

    @IBOutlet var instaTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        instaTableView.rowHeight = 320
        instaTableView.dataSource = self
        instaTableView.delegate = self
        instaTableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)")
                            self.Photos = responseDictionary["data"] as! [NSDictionary]
                            self.instaTableView.reloadData()
                    }
                }
        });
        task.resume()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func tableView(tableView: UITableView,   section: Int) -> Int {
//    return 1
//    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = instaTableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! InstaTableViewCell
        
        let movie = Photos[indexPath.row]
        print(movie)
        
        let pictureUrl = movie["images"]!["standard_resolution"]!!["url"] as! String
        print(pictureUrl)
        cell.InstaImage.setImageWithURL(NSURL (string : pictureUrl)!)
//        let title = movie["title"] as!String
//        let overview = movie["overview"] as!String
//        let posterPath = movie["poster_path"] as!String
//        
//        let BaseURL = "http://image.tmdb.org/t/p/w500"
//        
//        let ImageURL = NSURL(string: BaseURL + posterPath)
//        
//        
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//        cell.POSTERvIEW.setImageWithURL(ImageURL! )
        
        print("row \( indexPath.row)")
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
//        headerView.backgroundColor = UIColor.blackColor()
//        
//        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
//        profileView.clipsToBounds = true
//        profileView.layer.cornerRadius = 15;
//        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
//        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        // profileView.setImageWithURL(...)
        
//        headerView.addSubview(profileView)
//        header.addSubview(headerView)
        // Add a UILabel for the username here
//        header.textLabel!.text = "test"
        return header
        
          }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return self.Photos.count
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
