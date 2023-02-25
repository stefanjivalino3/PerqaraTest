//
//  ViewController.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 22/02/23.
//

import UIKit

class ViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var model = [GamesFavorite]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllItems()
    }
    
    
    //Core Data
    func getAllItems() {
        do {
            model = try context.fetch(GamesFavorite.fetchRequest())
            for n in model {
                print(n.gameId)
            }
        }
        catch {
            //error
        }
    }
    
    func createItem(name: String) {
        let newItem = GamesFavorite(context: context)
        newItem.name = name
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: GamesFavorite) {
        context.delete(item)
    }
    
    func updateItem(item: GamesFavorite, newName: String) {
        item.name = newName
        do {
            let items = try context.fetch(GamesFavorite.fetchRequest())
        }
        catch {
            //error
        }
    
    }


}

