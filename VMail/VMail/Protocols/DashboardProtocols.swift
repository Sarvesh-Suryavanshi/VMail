//
//  DashboardProtocols.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 03/12/21.
//

import Foundation

// MARK: - EmailView Protocol
protocol EmailViewProtocol: AnyObject {
    func updateContent()
}

// MARK: - EmailViewModel Protocol
protocol EmailViewModelProtocol: AnyObject {
    
    var emailCount: Int { get }
    
    func configure(view: EmailViewProtocol, model: EmailModelProtocol)
    func emails() -> Emails
    func deleteEmail(indexPath: IndexPath)
    func fetchEmails()
    func setFilterType(filter: Filter)
}

// MARK: - EmailModel Protocol
protocol EmailModelProtocol: AnyObject {
    func fetchEmails(completion: @escaping (_ emails: Emails) -> Void)
}
