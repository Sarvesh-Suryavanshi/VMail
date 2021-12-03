//
//  PersistentStore.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 03/12/21.
//

import RealmSwift

/// This class is responsible for  handling CRUD operations on Realm
class PersistentStore {
    
    // MARK: - Public Properties
    
    static let shared = PersistentStore()
    
    // MARK: - Private Properties
    
    private var realmInstance: Realm {
        try! Realm()
    }
    
    // Private Initializor
    
    private init() {}
}

// MARK: - Extension for CRUD operations for general objects in Realm

extension PersistentStore {
    
    var emailsFromDisk: Emails {
        let realm = self.realmInstance
        let emails = Array(realm.objects(Email.self))
        return emails
    }
    
    func emailsFromDisk(emailType: Type) -> Emails {
        let allEmails = self.emailsFromDisk
        guard !allEmails.isEmpty else { return allEmails }
        return allEmails.filter { email in
            let type = Type(rawValue: email.type)
            return type == emailType
        }
    }

    func saveToDisk(emails: Emails) {
        let realm = self.realmInstance
        try! realm.write({
            realm.add(emails)
        })
    }
    
    func saveToDisk(email: Email) {
        let realm = self.realmInstance
        try! realm.write({
            realm.add(email)
        })
    }
    
    func delete(email: Email) {
        let realm = self.realmInstance
        try! realm.write({
            realm.delete(email)
        })
    }
}
