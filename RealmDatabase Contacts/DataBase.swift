//
//  DataBase.swift
//  RealmDatabase Contacts
//
//  Created by sanjana pethani on 04/08/23.
//

import UIKit
import RealmSwift

class DataBase {
    static let shared = DataBase()
    
    private var realm = try! Realm()
    
    
    func getData() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveContact(contact: contact) {
        try!realm.write{
            realm.add(contact)
        }
    }
    
    func deletContact(contact: contact) {
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    func getAllcontacts() -> [contact] {
        return Array(realm.objects(contact.self))
    }
}
