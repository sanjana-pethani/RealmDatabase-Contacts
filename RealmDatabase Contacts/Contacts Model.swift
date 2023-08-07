//
//  Contacts Model.swift
//  RealmDatabase Contacts
//
//  Created by sanjana pethani on 03/08/23.
//

import UIKit
import RealmSwift


class contact: Object {
    @Persisted var firstName: String
    @Persisted var lastName: String

    
    
   convenience init(firstName: String, lastName: String) {
       self.init()
        self.firstName = firstName
        self.lastName = lastName
    }
}
