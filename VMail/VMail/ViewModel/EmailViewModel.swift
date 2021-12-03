//
//  EmailViewModel.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 03/12/21.
//

import Foundation


class EmailViewModel {
    
    // MARK: - Properties

    private weak var view: EmailViewProtocol?
    private var model: EmailModelProtocol?
    private var filterType: Filter = .all
}

// MARK: - EmailViewModel Protocol Methods

extension EmailViewModel: EmailViewModelProtocol {
   
    var emailCount: Int {
       return self.emails().count
    }
    
    func setFilterType(filter: Filter) {
        self.filterType = filter
    }
    
    func emails() -> Emails {
        switch self.filterType {
        case .all:
            return self.allEmails
        case .social:
            return self.socialEmails
        case .promotion:
            return self.promotionEmails
        }
    }
    
    func configure(view: EmailViewProtocol, model: EmailModelProtocol) {
        self.view = view
        self.model = model
    }

    
    func deleteEmail(indexPath: IndexPath) {
        let emails = self.emails()
        if emails.indices.contains(indexPath.row) {
            let email = emails[indexPath.row]
            PersistentStore.shared.delete(email: email)
        }
    }
    
    func fetchEmails() {
        
        if PersistentStore.shared.emailsFromDisk.isEmpty {
            self.model?.fetchEmails(completion: { [weak self] emails in
                guard let self = self else { return }
                // Sorting emails based on date.
                let sortedEmails = emails.sorted { $0.date > $1.date }
                // Saving data to Realm
                PersistentStore.shared.saveToDisk(emails: sortedEmails)
                // Telling the view to update itself.
                self.view?.updateContent()
            })
        } else {
            // Telling the view to update itself.
            self.view?.updateContent()
        }
    }
}

// MARK: - Private Methods

extension EmailViewModel {
    
    private var allEmails: Emails {
        return PersistentStore.shared.emailsFromDisk
    }
    
    private var socialEmails: Emails {
        return PersistentStore.shared.emailsFromDisk(emailType: .S)
    }
    
    private var promotionEmails: Emails {
        return PersistentStore.shared.emailsFromDisk(emailType: .P)
    }
}
