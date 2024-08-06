//
//  StorageProvider.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 06/08/24.
//

import Foundation
import CoreData

class StorageProvider {
    let persistenceContainer: NSPersistentContainer
    var currentUser: User?
    
    init(){
        persistenceContainer = NSPersistentContainer(name: "Login")
        persistenceContainer.loadPersistentStores { description, error  in
            if let error {
                fatalError("CoreData fail to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider {
    func saveUser(name: String, email: String, password: String, address: String, phone: String) {
        
        let user = User(context: persistenceContainer.viewContext)
        user.name = name
        user.email = email
        user.password = password
        user.address = address
        user.phone = phone
        
        do {
            try persistenceContainer.viewContext.save()
            print("User saved suceessfully")
            
        } catch {
            print("Failed to save \(error)")
        }
    }
    
    func validUser( email: String, password: String) -> Bool? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        do {
            let user = try persistenceContainer.viewContext.fetch(fetchRequest)
            currentUser = user.first
            return !user.isEmpty
        } catch {
            print("Failed to fetch \(error)")
            return nil
        }
    }
    
    func fetchUserByEmail(_ email: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.fetchLimit = 1 // Limitar a un solo resultado
        
        do {
            let users = try persistenceContainer.viewContext.fetch(fetchRequest)
            currentUser = users.first
            return currentUser
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }
    
    
    func deleteUser() {
        persistenceContainer.viewContext.delete(currentUser!)
        do {
            try persistenceContainer.viewContext.save()
        } catch {
            persistenceContainer.viewContext.rollback()
            print("Failed to delete \(error)")
        }
    }
    
    func editPassword(newPassword: String) {
//        let user =
//        user.password = newPassword
//
//        do {
//            try persistenceContainer.viewContext.save()
//            print("Password changed suceessfully")
//
//        } catch {
//            print("Failed to change the ppaswword \(error)")
//        }
    }
}
