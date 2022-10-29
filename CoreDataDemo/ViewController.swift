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
        print("Inserting Records--")
        insertData()
        print("Retriving Person Records--")
        retriveRecordsFromCoreData()
        print("Updating record -- 1-Person to 4-Person")
        updatingPersonRecord()
        print("Retriving Person Records--")
        retriveRecordsFromCoreData()
        print("Deleting Person Record --")
        deletingPersonRecord()
        print("Retriving Person Records--")
        retriveRecordsFromCoreData()
    }
    
    func insertData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        for i in 1...3{
            let person = NSManagedObject(entity: personEntity, insertInto: managedContext)
            person.setValue("\(i)-Person", forKey: "name")
            //person.setValue(Int32("\(i+20)"), forKey: "age")
            //person.setValue((i * 50000), forKey: "salary")
        }
        
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Data cannot be saved\(error) -- \(error.userInfo)")
        }
    }
    
    func retriveRecordsFromCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            let fetchResult = try managedContext.fetch(fetchRequest)
            for eachRecordOfPerson in fetchResult as! [NSManagedObject]{
                print(eachRecordOfPerson.value(forKey: "name") as! String)
                //print(eachRecordOfPerson.value(forKey: "age") as! Int32)
                //print(eachRecordOfPerson.value(forKey: "salary") as! Double)
            }
        } catch {
            print("Failed to fetch records from person database")
        }
    }
    
    func updatingPersonRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequestForUpdateQuery : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Person")
        fetchRequestForUpdateQuery.predicate = NSPredicate(format: "name = %@", "1-Person")
        do{
            let update = try managedContext.fetch(fetchRequestForUpdateQuery)
            let personObjectToBeUpdated = update[0] as! NSManagedObject
            personObjectToBeUpdated.setValue("4-Person", forKey: "name")
            personObjectToBeUpdated.setValue(25, forKey: "age")
            personObjectToBeUpdated.setValue(70454.34, forKey: "salary")
        }catch{
            print("record not updated")
        }
    }
    
    func deletingPersonRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
       let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequestForDelete = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequestForDelete.predicate = NSPredicate(format: "name = %@", "4-Person")
        do{
            let recordToBeDeleted = try managedContext.fetch(fetchRequestForDelete)
            let personObjToBeDeleted = recordToBeDeleted[0] as! NSManagedObject
            managedContext.delete(personObjToBeDeleted)
            
            do{
                try managedContext.save()
            } catch {
                print("Chages Not saved")
            }
        } catch{
            print("Error deleting person record")
        }
    }
}
