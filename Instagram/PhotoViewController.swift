//
//  PhotoViewController.swift
//  Instagram
//
//  Created by Dhiman on 1/21/16.
//  Copyright © 2016 Dhiman. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    var Photos : [NSDictionary] = []
    let HeaderViewIdentifier = "TableViewHeaderView"
    var isMoreDataLoading = false
    var refreshControl: UIRefreshControl!

    @IBOutlet var instaTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        instaTableView.rowHeight = 320
        instaTableView.dataSource = self
        instaTableView.delegate = self
        instaTableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        instaTableView.insertSubview(refreshControl, atIndex: 0)

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
    func loadMoreData() {
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
                            self.isMoreDataLoading = false
                        
                    }
                }
        });
        task.resume()
        

    
    // ... Create the NSURLRequest (myRequest) ...
    
    // Configure session so that completion handler is executed on main UI thread
        
    }
    func onRefresh() {
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

        delay(0.2) { () -> () in
                       self.refreshControl.endRefreshing()
        }
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }


    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = instaTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - instaTableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && instaTableView.dragging) {
                isMoreDataLoading = true
                loadMoreData()
                print("======get to bottom====")
                
                // ... Code to load more results ...
            }
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        instaTableView.deselectRowAtIndexPath(indexPath, animated:true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func tableView(tableView: UITableView,   section: Int) -> Int {
//    return 1
//    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = instaTableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! InstaTableViewCell
        
        let movie = Photos[indexPath.section]
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
//         Use the section number to get the right URL
//         profileView.setImageWithURL(...)
        
        let path = Photos[section]["user"]!["profile_picture"] as? String
        profileView.setImageWithURL(NSURL(string: path!)!)
        
        
        let name = Photos[section]["user"]!["username"] as? String
    
        
        
//         Add a UILabel for the username here
        let nameLabel = UILabel(frame: CGRect(x: 50, y: 10, width: 200, height: 30))
        nameLabel.text = name
        headerView.addSubview(nameLabel)
        headerView.addSubview(profileView)

        header.addSubview(headerView)

        return header
        
          }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.Photos.count
    }
    


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         var vc = segue.destinationViewController as! PhotoDetailViewController
        var indexPath = instaTableView.indexPathForCell(sender as! UITableViewCell)
        vc.PhotoUrl = Photos[indexPath!.section]["images"]!["standard_resolution"]!!["url"] as! String
        print("====")
        print(indexPath?.section)
        
    }
    

}
