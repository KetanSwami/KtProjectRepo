//
//  ContactListTableViewController.swift
//  ContactListApplication
//
//  Created by ketan on 02/01/18.
//  Copyright © 2018 MindIT. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController
{

    var arrayContactList : NSArray = NSArray()
    
    override func viewDidLoad()
    {
        LoadingIndicatorView.show()

        super.viewDidLoad()
        self.getContactlist()
    }
    
    func getContactlist()
    {
        
        let pathParameter  : NSString = "/users"
        CommunicationManager.sharedInstance.execTask(pathParam:pathParameter , queryParam: "", requestType: "get", jsonDict:NSDictionary())
        {
            (status, response) in
            
            DispatchQueue.main.async { () -> Void in
                LoadingIndicatorView.hide()
            }

            if status
            {
                if(response != nil)
                {
                    self.arrayContactList = response as! NSArray
                    
                    DispatchQueue.main.async { () -> Void in
                        self.tableView.reloadData();
                        LoadingIndicatorView.hide()
                    }
                    
                    
                    //  self.arrayForCity = NSMutableArray.init(array: jsonArray) as! [NSDictionary];
                }
            }
            else
            {
                DispatchQueue.main.async { () -> Void in
                    
                    let alert = UIAlertController(title: "Alert", message: "Some error occurred", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                    LoadingIndicatorView.hide()
                }
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayContactList.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:"customeTableCell", for: indexPath)
        
        let dictForContact :NSDictionary  = arrayContactList[indexPath.row] as! NSDictionary
        
        let labelName : UILabel = cell.viewWithTag(1) as! UILabel
        
        labelName.text = dictForContact.value(forKey: "name") as? String
        
        let labelContactNumber :UILabel = cell.viewWithTag(2) as! UILabel
        
        labelContactNumber.text = dictForContact.value(forKey: "phone") as? String
        
        let labelEmailId :UILabel = cell.viewWithTag(3) as! UILabel
        
        labelEmailId.text = dictForContact.value(forKey: "email") as? String
        
        
        
        return cell;
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let contactDict = arrayContactList[indexPath.row];
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailsViewController") as! ContactDetailsViewController
        secondViewController.contactDictionary = contactDict as! NSDictionary;
        self.navigationController?.pushViewController(secondViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
