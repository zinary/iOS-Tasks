//
//  ViewController.swift
//  CoreDataTableView
//
//  Created by RamKumar on 16/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var people = [Person]()
    override func viewDidLoad() {
        tableView.dataSource = self
        super.viewDidLoad()
        
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        do{
          let people = try  PersistenceService.context.fetch(fetchRequest)
            self.people = people
        }catch{
            print("error fetching")
        }
        tableView.reloadData()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: nil, preferredStyle:.alert )
       
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
            
        }
       
        
        let alertAction = UIAlertAction(title: "Save", style: .default) { (alertaction) in
            
            guard let name = alert.textFields?.first!.text! else {
                chkalrt()
                return
                
            }
            guard let age = alert.textFields?.last!.text! else {
               chkalrt()
                return
                
            }
            print(name)
            print(age)
            
            let person = Person(context: PersistenceService.context)
            
            person.name = name
            person.age = Int16(age)!
            
            PersistenceService.saveContext()
            self.people.append(person)
            self.tableView.reloadData()
        }

        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        func chkalrt(){
            alertAction.isEnabled=false
        }
    }
    

}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel!.text = people[indexPath.row].name
        cell.detailTextLabel!.text = String(people[indexPath.row].age)
        print("table")
        return cell
    }
    
        
    
}
