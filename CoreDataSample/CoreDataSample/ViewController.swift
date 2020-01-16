//
//  ViewController.swift
//  CoreDataSample
//
//  Created by RamKumar on 16/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var scoreField: UITextField!
    
    
    var score = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        scoreField.text = "\(score)"
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func incrementButton(_ sender: Any) {
        score += 1
        scoreField.text = "\(score)"
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newentity = NSManagedObject(entity: entity!, insertInto: context)
        
        newentity.setValue(score, forKey: "number")
        
        do{
            try context.save()
            print("saved")
        }catch{
            print("failed to save")
        }
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults=false
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                score = data.value(forKey:"number") as! Int
            }
        }catch{
            print("failed to get data")
        }
    }
}

