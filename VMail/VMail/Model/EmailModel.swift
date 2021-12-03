//
//  EmailModel.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 03/12/21.
//

import Foundation

class EmailModel: EmailModelProtocol {
    
    func fetchEmails(completion: @escaping (_ emails: Emails) -> Void) {
        if let path = Bundle.main.path(forResource: "emails", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.parsingDF)
                let emails = try decoder.decode(Emails.self, from: data)
                completion(emails)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
