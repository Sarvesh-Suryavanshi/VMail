//
//  Extension.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 02/12/21.
//

import Foundation

extension DateFormatter {
    
    static var parsingDF : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        return dateFormatter
    }
}
