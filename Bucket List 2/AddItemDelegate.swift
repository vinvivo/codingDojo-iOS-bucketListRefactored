//
//  AddItemDelegate.swift
//  Bucket List 2
//
//  Created by Vinney Le on 9/21/17.
//  Copyright © 2017 Vinney Le. All rights reserved.
//

import UIKit

// One protocol to contain all delegated functions
protocol AddItemDelegate: class {
    
    // Cancel button function
    func addItemViewController(_ controller: AddItemViewController, didPressCancelButton button: UIBarButtonItem)
    
    // Save button function utilizes a partially customized function that includes
    // an optional parameter 'at indexPath: NSIndexPath?'
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem itemText: String, at indexPath: NSIndexPath?)

}

