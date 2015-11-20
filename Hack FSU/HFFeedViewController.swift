//
//  HFFeedViewController.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 10/22/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit
import Glyptodon
import Parse

class HFFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UI Outlets
    
    @IBOutlet weak var feedTableView: UITableView!

    @IBOutlet weak var feedSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var tableViewContainerView: UIView!
    
    
    // MARK: Class Variables
    var updateFeedArray:[HFUpdate] = [HFUpdate]()
    var twitterFeedArray:[String] = [String]()
    var scheduleFeedArray:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.setContentOffset(CGPointZero, animated: false)
        getUpdatesFromParse()
    }
    
    override func viewWillLayoutSubviews() {
        checkForContent()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let update = 0
        let scheudle = 1
        let twitter = 2
        
        switch (self.feedSegmentControl.selectedSegmentIndex) {
        case update:
            return updateFeedArray.count
        case scheudle:
            return scheduleFeedArray.count
        case twitter:
            return twitterFeedArray.count
        default: return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let update = 0
        let scheudle = 1
        let twitter = 2
        
        switch (self.feedSegmentControl.selectedSegmentIndex) {
        case update:
            
            let cell:HFUpdateTableViewCell = tableView.dequeueReusableCellWithIdentifier("HFUpdateTableViewCell") as! HFUpdateTableViewCell
            let update = updateFeedArray[indexPath.row]
            cell.title.text = update.getTitle()
            cell.subTitle.text = update.getContent()
            print(update.getTimestamp())
            cell.timestamp.text = update.getTimestamp()
            print(update.getTimestamp())
            return cell
            
        case scheudle: let cell = UITableViewCell(); return cell
            
            
            
            
            
            
            
            
        case twitter: let cell = UITableViewCell(); return cell
            
            
            
            
            
        default: let cell = UITableViewCell(); return cell
        }

    }
    
    @IBAction func feedSegControlValueChanged(sender: AnyObject) {
        checkForContent()
    }
    
    /* checkForContent will check if there is data to be displayed in the view. If not, it will set the correct Glyptodon view. */
    func checkForContent() {
        let update = 0
        let schedule = 1
        let twitter = 2
        
            switch(self.feedSegmentControl.selectedSegmentIndex) {
            case update: if updateFeedArray.count == 0 {
                feedTableView.alpha = 0.0
                tableViewContainerView.glyptodon.show("Getting Updates. Please Wait.")
            }   else {
                tableViewContainerView.glyptodon.hide()
                feedTableView.alpha = 1.0
                }
            case twitter: if twitterFeedArray.count == 0 {
                feedTableView.alpha = 0.0
                tableViewContainerView.glyptodon.show("Getting Tweets. Please Wait.")
            }   else {
                feedTableView.alpha = 1.0
                tableViewContainerView.glyptodon.hide()
                }
            case schedule: if scheduleFeedArray.count == 0 {
                feedTableView.alpha = 0.0
                tableViewContainerView.glyptodon.show("Getting Scheudle. Please Wait.")
            }   else {
                feedTableView.alpha = 1.0
                tableViewContainerView.glyptodon.hide()
                }
            default: break
        } // End of Switch
    }
    
    func getUpdatesFromParse() {
        var updatesArray:[HFUpdate] = [HFUpdate]()
        let query = PFQuery(className: "Update")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let _ = objects {
                for update in objects! {
                    let newUpdateTitle = update.objectForKey("title") as! String
                    let newUpdateContent = update.objectForKey("subtitle") as! String
                    let tempTimestamp = update.createdAt!
                    
                    let newUpdateTimestamp = self.dateToString(tempTimestamp)
                    
                    let newUpdate = HFUpdate(title: newUpdateTitle, content: newUpdateContent, timestamp: newUpdateTimestamp)
                    updatesArray.append(newUpdate)
                    
                }
                self.updateFeedArray = updatesArray
                self.feedTableView.reloadData()
                self.checkForContent()
            } else {
                print(error)
            }
        }
    }
    
    func dateToString(date: NSDate) -> String {
        //format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        let dateString = dateFormatter.stringFromDate(date)
        let brokenStringArray = dateString.componentsSeparatedByString(",")
        let dayOfWeek = brokenStringArray[0]
        let shortDay = longDayToShortDay(dayOfWeek)
        let time = timeAsIWantIt(date)
        return "\(shortDay) \(time)"
    }
    
    func longDayToShortDay(day: String) -> String {
        switch(day) {
        case "Sunday": return "Sun"
        case "Monday": return "Mon"
        case "Tuesday": return "Tues"
        case "Wedneday": return "Wed"
        case "Thursday": return "Thur"
        case "Friday": return "Fri"
        case "Saturday": return "Sat"
        default: return "Sat"
        }
    }
    
    func timeAsIWantIt(date: NSDate) -> String {
        //format date
       
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateString = dateFormatter.stringFromDate(date)
        
        let timeComponents = dateString.componentsSeparatedByString(":")
        let hour = Int(timeComponents[0])
        
        return "\(hour!):\(timeComponents[1])"
        
    }
    
}// End of View Controller Class
