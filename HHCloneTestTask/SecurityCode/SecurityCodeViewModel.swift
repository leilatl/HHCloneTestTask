//
//  SecurityCodeViewModel.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import Foundation

class SecurityCodeViewModel: ObservableObject {
    enum Event {
        case next
    }
    
    @Published var email: String

    var onAction: ((Event) -> Void)?
    
    init(email: String) {
        self.email = email
    }
}
