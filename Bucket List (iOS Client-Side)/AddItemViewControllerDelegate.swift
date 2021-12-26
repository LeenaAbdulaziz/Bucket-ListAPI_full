//
//  AddItemViewControllerDelegate.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Linah abdulaziz on 22/05/1443 AH.
//

import Foundation
protocol AddItemViewControllerDelegate :class{
    func itemSaved(by controller : AddItemViewController, with text:String, at indexPath: NSIndexPath?)
    func CancelButtonPressed (By controller: AddItemViewController)
}
