//
//  ViewController.swift
//  tableviewlast
//
//  Created by Janakiraman Kanagaraj on 31/12/19.
//  Copyright © 2019 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var data : [String] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0...10
        {
            data.append("\(i)")
            
        }
       
        tableView.dataSource = self
        tableView.delegate = self
    }
                
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       

        let alertController = UIAlertController(title: "Hint", message: "selected row \(indexPath.row)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil )
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
         tableView.deselectRow(at: indexPath , animated: true)
            }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let  cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse")! as! CustomTableViewCell
         let text = data[indexPath.row]
        let odd = " odd",even=" even"
//        cell.label.text = text
        if indexPath.row % 2 == 0
        {
            cell.label.text = text+even
            
        }else{
            cell.contentView.backgroundColor = .white
            cell.label.text = text+odd
        }
        
     
        
        return cell
    }

}

