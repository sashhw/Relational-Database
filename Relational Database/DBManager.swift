//
//  DBManager.swift
//  Relational Database
//
//  Created by Sasha on 9/3/21.
//

import Foundation
import SQLite

class Manager {
    private var db: Connection!
    private var dogs: Table!
    private var id: Expression<Int>!
    private var name: Expression<String>!
    private var breed: Expression<String>!
    private var age: Expression<Int>!
    
    
    init () {
        do {
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            db = try Connection("\(path)/my_dogs.sqlite3")
            
            dogs = Table("dogs")
            
            id = Expression<Int>("id")
            name = Expression<String>("name")
            breed = Expression<String>("breed")
            age = Expression<Int>("age")
            
            
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                try db.run(dogs.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(breed, unique: true)
                    t.column(age)
                }
                )
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
                
        } catch {
            print(error.localizedDescription)
            }
        }
    public func addDog(nameValue: String, breedValue: String, ageValue: Int)
    {
        do {
            try db.run(dogs.insert(name <- nameValue, breed <- breedValue, age <- ageValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getDogs() -> [DogModel] {
        var dogModels: [DogModel] = []
        dogs = dogs.order(id.desc)
        
        do {
            for dog in try db.prepare(dogs) {
                let dogModel: DogModel = DogModel()
                
                dogModel.id = dog[id]
                dogModel.name = dog[name]
                dogModel.breed = dog[breed]
                dogModel.age = dog[age]
                
                dogModels.append(dogModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        return dogModels
    }
    
    public func getDogs(idValue: Int) -> DogModel {
        let dogModel: DogModel = DogModel()
        
        do {
            let dog: AnySequence<Row> = try db.prepare(dogs.filter(id == idValue))
            try dog.forEach({ (rowValue) in
                dogModel.id = try rowValue.get(id)
                dogModel.name = try rowValue.get(name)
                dogModel.breed = try rowValue.get(breed)
                dogModel.age = try rowValue.get(age)
            })
        } catch {
            print(error.localizedDescription)
        }
        return dogModel
    }
    
    public func updateDog(idValue: Int, nameValue: String, breedValue: String, ageValue: Int) {
        do {
            let dog: Table = dogs.filter(id == idValue)
            try db.run(dog.update(name <- nameValue, breed <- breedValue, age <- ageValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteDog(idValue: Int) {
        do {
            let dog: Table = dogs.filter(id == idValue)
            try db.run(dog.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    }

