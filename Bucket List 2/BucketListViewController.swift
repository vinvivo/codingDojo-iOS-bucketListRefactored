//
//  ViewController.swift
//  Bucket List 2
//
//  Created by Vinney Le on 9/20/17.
//  Copyright © 2017 Vinney Le. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemDelegate {
    // Conform to AddItemDelegate by implementing required functions from the protocol.

    var itemsList: [String] = ["Get milk", "Pack up house", "Schedule movers", "Clean Vi's apartment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("BucketListViewController loaded")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /* --------------------------------------------------
         Conform to UITableViewController by:
         1) Specifying how many rows, and
         2) Telling each row where to get its data from.
       -------------------------------------------------- */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        cell.textLabel?.text = itemsList[indexPath.row]
        
        return cell
        
    }

    /* --------------------------------------------------
         Cancel button functionality.
       -------------------------------------------------- */
    func addItemViewController(_ controller: AddItemViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   
    /* --------------------------------------------------
         Add/ Edit functionality.
         If an indexPath is sent, carry out the edit logic.
         If no indexPath is sent, carry out the add logic.
     -------------------------------------------------- */
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem itemText: String, at indexPath: NSIndexPath?) {
        
        // If an indexPath is sent, it means the user is editing an existing row.
        if let idx = indexPath {    // This partially customized function may receive an indexPath, so need to safely unwrap it.
            itemsList[idx.row] = itemText
        }
        // If no indexPath is sent, it means the user is adding a new item.
        else {
            itemsList.append(itemText)
        }
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    /* ---------------------------------------------------
        How to know which cell user wants to edit?
        Tapping a row will perform a particular segue (EditItemSegue) and pass a
        'sender'.  Before any segue happens, our code prepares for the segue
        according to the 'prepare(for segue...' below.
       ------------------------------------------------ */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        print("Row \(indexPath) selected")
        
    }

    /* ---------------------------------------------------
         Delete with a swipe functionality.
     ------------------------------------------------ */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        itemsList.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    // If using a Detail Disclosure button, do the following:
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }

    /* --------------------------------------------------
         Prepare for segue to AddItemViewController by setting self as its delegate.
       -------------------------------------------------- */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*   Now we need to pass information between this controller (a
         delegate of the cancel and save buttons) and the Add Item View
         Controller.  Looking at the story board, there are several views
         the information needs to be passed between:
         Self -> Navigation Controller -> AddItemViewController (as
         topViewController in the "stack")
         */
        if segue.identifier == "AddItemSegue" {
            
            // Send self to the target.
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegateReceiver = self
            
        } else if segue.identifier == "EditItemSegue" {
            
            // Still need to send self to the target...
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegateReceiver = self
            
            // ...but also need to send which cell needs to be edited.
            let indexPath = sender as! NSIndexPath
            let itemText = itemsList[indexPath.row]
            controller.itemReceiver = itemText
            controller.indexPathReceiver = indexPath
        }
    }

    
}



