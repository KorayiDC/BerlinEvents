//
//  MasterViewController.swift
//  Berlin
//
//  Created by Koray Ece on 08.06.16.
//  Copyright © 2016 Koray Ece. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBAction func aboutPressed(sender: AnyObject) {
        
        
        let alert = UIAlertController(title: "Version 1.2", message: "Mit dieser App, sehen sie alle aktuellen Veranstaltungen in Berlin und Brandenburg. Konsole: \(objects)", preferredStyle: UIAlertControllerStyle.Alert)
        
        // print json ist nur auf einem gerät verfügbar und nicht im ios simulator
        
        alert.addAction(UIAlertAction(title: "Made by Koray Ece", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
  
    
    @IBAction func safariPressed(sender: AnyObject) {
        
       UIApplication.sharedApplication().openURL(NSURL(string: "http://daten.berlin.de")!)
    }
    
    
    
    var detailViewController: DetailViewController? = nil
    var objects = [[String: String]]()
    var url:NSURL? = NSURL(string: "daten.berlin.de")
  
    

    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       

    
        let urlString = "http://www.berlin.de/sen/wirtschaft/service/maerkte-feste/strassen-volksfeste/index.php/index/all.json?q="
    
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                
                if json["messages"] != nil {
                    // jetzt gehts los
                    parseJson(json)
                    print(json)
                    
                
                } else {
                    print("Fehler. Eventuell keine Internetverbindung?")
                }
            }
        }
    }
    
    
    
    
    func parseJson(json: JSON) {
        
        for index in json["index"].arrayValue {
            
            let title = index["bezeichnung"].stringValue
            let body = index["strasse"].stringValue
            let sigs = index["veranstalter"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            objects.append(obj)
        }
        
        tableView.reloadData()
    }
    

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object["title"]
        cell.detailTextLabel!.text = object["body"]
        return cell
    }

   
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Events in Berlin"
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
        
    }
   
}

