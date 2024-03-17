//
//  EntryViewModel.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 15.03.2024.
//

import Foundation
import SwiftUI

class EntryViewModel: ObservableObject {
    enum Event {
        case next(String)
    }
    
    @Published var email: String = ""
    
    var isEmailValid: Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let result = email.range(of: emailPattern, options: .regularExpression)
        return result != nil
    }

    var onAction: ((Event) -> Void)?
}
