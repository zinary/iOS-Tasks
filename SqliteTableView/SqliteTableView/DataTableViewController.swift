//
//  DataTableViewController.swift
//  SqliteTableView
//
//  Created by RamKumar on 23/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
  
    @IBOutlet weak var collegeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    
}


class DataTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var userTable = [User]()
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  userTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath) as! TableViewCell
        cell.nameLabel.text = userTable[indexPath.row].name
        cell.departmentLabel.text = userTable[indexPath.row].department
        cell.collegeLabel.text = userTable[indexPath.row].college
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted \(indexPath.row)")
            let cid = userTable[indexPath.row].id
            SQlite.shared.deleteDataFromTable(id: cid)
            self.userTable.remove(at: indexPath.row)
            self.TableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    let destVC:ViewController = segue.destination as! ViewController
    if segue.identifier == "update"{
    let selectedRow = self.TableView.indexPathForSelectedRow!.row
    print(self.userTable[selectedRow])
    self.userTable =  SQlite.shared.getDataFromTable()
        destVC.update = true
        destVC.selectedUserData = userTable[selectedRow]
    }
        
        else if segue.identifier == "add"{
            destVC.deletebtn?.backgroundColor = .red
        }
    }
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        TableView.dataSource = self
        TableView.delegate = self
        userTable =  SQlite.shared.getDataFromTable()
        TableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
         userTable =  SQlite.shared.getDataFromTable()
         TableView.reloadData()
    }
    
}
