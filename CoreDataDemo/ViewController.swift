//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Vishal Jagtap on 19/10/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       insertData()
    }
    
    func insertData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        for i in 1...2{
            let person = NSManagedObject(entity: personEntity, insertInto: managedContext)
            person.setValue("Pratik", forKey: "name")
            person.setValue(24, forKey: "age")
            person.setValue(50000.00, forKey: "salary")
        }
        
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Data cannot be saved\(error) -- \(error.userInfo)")
        }
    }
}
