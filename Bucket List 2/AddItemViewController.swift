//
//  AddItemVC.swift
//  Bucket List 2
//
//  Created by Vinney Le on 9/21/17.
//  Copyright © 2017 Vinney Le. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    // The following variables "catch" information passed from the prepared segue.
    // 'delegateReceiver' - so that BucketListViewController can set itself as the cancel button delegate.
    // 'itemReceiver' - so that the screen autofills the text field.
    // 'indexPathReceiver' - so that the save button edits the correct row.
    weak var delegateReceiver: AddItemDelegate?
    var itemReceiver: String?
    var indexPathReceiver: NSIndexPath?
    
    // Add an outlet for the textField.
    @IBOutlet weak var itemTextField: UITextField!

    // Need the Cancel button to trigger an action that tells the delegate that the button was pressed.
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        delegateReceiver?.addItemViewController(self, didPressCancelButton: sender)
    }
    
    // Need the Save button to trigger an action that tells the delegate that the button was pressed and passes the required information (i.e., protocol variables '_ controller' and 'didFinishAddingItem item')
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        delegateReceiver?.addItemViewController(self, didFinishAddingItem: itemTextField.text!, at: indexPathReceiver)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = itemReceiver
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

