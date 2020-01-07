//
//  ViewController.swift
//  task2
//
//  Created by Janakiraman Kanagaraj on 03/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AddTask {
    @IBOutlet weak var tableView: UITableView!
   
    var profileData : [ProfileData] = []
//    func createProfileData(){
//       profileData.append(ProfileData(name: "dName", age: 22, gender: "dGender"))
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddViewController
        vc.delegate = self
    }
    
    func addTask(name: String, age: Int, gender: String) {
        profileData.append(ProfileData(name: name, age: age, gender: gender))
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        self.tableView.estimatedRowHeight = 44
//        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath) as! ListTableViewCell
    
        let data = profileData[indexPath.row]
        
        cell.profileName.text = data.name
        cell.profileAge.text = String(data.age)
        cell.profileGender.text = data.gender
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            profileData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }

}

