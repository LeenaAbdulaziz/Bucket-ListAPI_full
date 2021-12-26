//
//  AddItemViewController.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Linah abdulaziz on 22/05/1443 AH.
//

import UIKit

class AddItemViewController: UITableViewController {


    
    var delegate : AddItemViewControllerDelegate?
        
        var item : String?
        var indexPath:NSIndexPath?

       
    @IBOutlet weak var rowitem: UITextField!
    
        
    @IBAction func CancelButton(_ sender: UIBarButtonItem) {
        delegate?.CancelButtonPressed(By: self)

    }
   
        @IBAction func SaveButtonPressed(_ sender: UIBarButtonItem) {
            
            let text = rowitem.text!
            delegate?.itemSaved(by: self, with:text,at : indexPath )
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            rowitem.text = item

            // Do any additional setup after loading the view.
        }
        

     

    }
