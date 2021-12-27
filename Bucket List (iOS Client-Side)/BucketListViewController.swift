//
//  ViewController.swift
//  Bucket List (iOS Client-Side)
//
//  Created by Linah abdulaziz on 22/05/1443 AH.
//

import UIKit

class BucketListViewController: UITableViewController , AddItemViewControllerDelegate {
    
    let BucketListApi = "https://saudibucketlistapi.herokuapp.com/tasks/"
    
    
    var items = [Bucket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getallList()
    }
    
    func getallList() {
        ApiManager.getApiResponse(urlPath: BucketListApi) { data, error in
            do {
                
                self.items = try JSONDecoder().decode([Bucket].self, from: data!)
                
                
                
                DispatchQueue.main.async {
                    // main thread
                    self.tableView.reloadData()
                }
                
            }catch{
                print(error)
            }
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = (items[indexPath.row]).objective
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        performSegue(withIdentifier: "Edititemseque", sender: indexPath)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        ApiManager.deleteTasks(index: items[indexPath.row].id, completionHandler: {
            data , response, error in
            
            self.getallList()
        })
    }
    
    
    // prepare with seque  identifier
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is UIBarButtonItem{
            let destination = segue.destination as! UINavigationController
            
            let addItem = destination.topViewController as! AddItemViewController
            
            addItem.delegate = self
        }
        else if sender is IndexPath{
            let destination = segue.destination as! UINavigationController
            
            let addItem = destination.topViewController as! AddItemViewController
            
            addItem.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row].objective
            
            addItem.item = item
            addItem.indexPath = indexPath
            
            
        }
        
    }
    
    
    
    
    
    
    
    func CancelButtonPressed(By controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemViewController, with text: String, at indexPath: NSIndexPath?) {
        
        
        if let ip = indexPath{
            updateTask(index: items[ip.row].id, text: text)
        }
        else{
            AddNewTask(text: text)
            
        }
        
        DispatchQueue.main.async {
            // main thread
            self.tableView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func AddNewTask(text:String){
        ApiManager.addTaskWithObjective(objective: text, completionHandler: {
            data , response, error in
            
            self.getallList()
        })
    }
    
    
    
    func updateTask(index: Int, text: String){
        ApiManager.updateTask(index: index, objective: text, completionHandler: {
            data , response, error in
            
            print(response ?? "no response")
          
            self.getallList()
        })
    }
    
}
