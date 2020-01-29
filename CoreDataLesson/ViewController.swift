//
//  ViewController.swift
//  CoreDataLesson
//
//  Created by David Svensson on 2020-01-29.
//  Copyright © 2020 David Svensson. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource{
    
    let cellId = "cellId"
    
   // var items = ["gurka", "ost", "majonäs"]
    
    var shoppingItems : [ShoppingItem] = []
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemsTableView.dataSource = self
        loadItems()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //items.count
        shoppingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
       // cell.textLabel?.text = items[indexPath.row]
        let item = shoppingItems[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
        
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Item", message: "Add a new Item", preferredStyle: .alert)
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let textField = alert.textFields?.first else {return}
            guard let itemToSave = textField.text else {return}
            
          //  self.items.append(itemToSave)
            self.saveItem(name: itemToSave)
            self.itemsTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
      
        
        present(alert, animated: true)
    }
    
    func saveItem(name: String) {
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        guard let entity = NSEntityDescription.entity(forEntityName: "ShoppingItem", in: managedContext) else {return}
        
        let item = ShoppingItem(entity: entity, insertInto: managedContext)
        
        item.name = name
        item.done = false
        
        
        do {
         try managedContext.save()
            shoppingItems.append(item)
        } catch let error as NSError {
            print("Save error \(error)")
        }
    }
    
    func loadItems() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
             
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<ShoppingItem>(entityName: "ShoppingItem")
        
        do {
            shoppingItems = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    
}

