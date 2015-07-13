//
//  ViewController.swift
//  BearchChat
//
//  Created by Diego Borges on 7/13/15.
//  Copyright (c) 2015 drborges. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var messages = [String]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messages.append("Well hello there!")
        tableView.dataSource = self
        tableView.reloadData()
        var ref = Firebase(url:"https://bearch-chat.firebaseio.com/messages")
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            let message = snapshot.value
            self.messages.append(message as! String)
            self.tableView.reloadData()
        })

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId: NSString = "messagesCell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellId as String) as! UITableViewCell
        
        let message = self.messages[indexPath.row]
        cell.textLabel!.text = message
        
        return cell
    }
}

