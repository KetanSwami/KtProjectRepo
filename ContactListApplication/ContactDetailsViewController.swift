//
//  ContactDetailsViewController.swift
//  ContactListApplication
//
//  Created by ketan swami on 02/01/18.
//  Copyright © 2018 MindIT. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var contactDictionary : NSDictionary = [:]

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactDesignation: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
         {
         "id": 10,
         "name": "Clementina DuBuque",
         "username": "Moriah.Stanton",
         "email": "Rey.Padberg@karina.biz",
         "address": {
         "street": "Kattie Turnpike",
         "suite": "Suite 198",
         "city": "Lebsackbury",
         "zipcode": "31428-2261",
         "geo": {
         "lat": "-38.2386",
         "lng": "57.2232"
         }
         },
         "phone": "024-648-3804",
         "website": "ambrose.net",
         "company": {
         "name": "Hoeger LLC",
         "catchPhrase": "Centralized empowering task-force",
         "bs": "target end-to-end models"
         }
         }
         */
        
        self.contactName.text = contactDictionary .value(forKey: "name") as? String
        self.contactDesignation.text = ((contactDictionary .value(forKey: "company") as! NSDictionary).value(forKey: "name") as! NSString as String)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellDetails", for: indexPath)
        
        let labelHint : UILabel = cell.viewWithTag(1) as! UILabel
        
        let labelDescription: UILabel = cell.viewWithTag(2) as! UILabel
        
        if indexPath.row == 0
        {
            labelHint.text = "Username"
            labelDescription.text = contactDictionary.value(forKey: "username") as? String
        }
        else if indexPath.row == 1
        {
            labelHint.text = "E-mail Id"
            labelDescription.text = contactDictionary.value(forKey: "email") as? String
        }
        else if indexPath.row == 2
        {
            labelHint.text = "Phone"
            labelDescription.text = contactDictionary.value(forKey: "phone") as? String
        }
        else if indexPath.row == 3
        {
            labelHint.text = "Website"
            labelDescription.text = contactDictionary.value(forKey: "website") as? String
        }
        else if indexPath.row == 4
        {
            labelHint.text = "Address"
            labelDescription.text = "street :\(((contactDictionary.value(forKey: "address") as? NSDictionary)?.value(forKey: "street") as! NSString as String)) \nSuit : \((((contactDictionary.value(forKey: "address") as? NSDictionary)?.value(forKey: "suite") as! NSString as String))) \nCity: \(((contactDictionary.value(forKey: "address") as? NSDictionary)?.value(forKey: "city") as! NSString as String)) \nZipcode : \(((contactDictionary.value(forKey: "address") as? NSDictionary)?.value(forKey: "zipcode") as! NSString as String))"
        }


        
        
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
      return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 4
        {
            return  120
        }
        
        return 70
    }

    
}
