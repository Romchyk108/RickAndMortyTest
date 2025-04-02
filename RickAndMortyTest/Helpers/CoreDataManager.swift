//
//  CoreDataManager.swift
//  RickAndMortyTest
//
//  Created by Roman Shestopal on 01.04.2025.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    var characterEntitys: [NSManagedObject] = []
    
    func save(character: Character) {
        DispatchQueue.main.async { [weak self] in
            guard let appDelegate =
              UIApplication.shared.delegate as? AppDelegate else {
              return
            }
            let managedContext =
              appDelegate.persistentContainer.viewContext
            let entity =
              NSEntityDescription.entity(forEntityName: "EntityCharacter",
                                         in: managedContext)
           if let entity {
                let characterEntity = NSManagedObject(entity: entity,
                                                      insertInto: managedContext)
                characterEntity.setValue(character.id, forKeyPath: "id")
                characterEntity.setValue(character.name, forKeyPath: "name")
                characterEntity.setValue(character.image, forKeyPath: "image")
                if let dataImega = character.dataImage {
                    characterEntity.setValue(dataImega, forKeyPath: "dataImage")
                }
                do {
                    self?.characterEntitys.append(characterEntity)
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func getCharacters() -> [Character] {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return []
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "EntityCharacter")
          do {
              characterEntitys = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        let characters: [Character] = characterEntitys.map { characterEntity in
            let character = Character(id: characterEntity.value(forKey: "id") as! Int64, name: characterEntity.value(forKey: "name") as! String, image: characterEntity.value(forKey: "image") as! String, dataImage: characterEntity.value(forKey: "dataImage") as? Data)
            return character
        }
        return characters
    }
    
    func deleteAllData() {
        DispatchQueue.main.async {
            guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else { return }
            
            let managedContext =  appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EntityCharacter")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedContext.execute(deleteRequest)
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
}
