//
//  ConjugationService.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 17.03.2024.
//

import Foundation
class ConjugationService {
    enum ConjugatableWords {
        case people, vacancies
        
    }
    
    static func conjugate(word: ConjugatableWords, number: Int) -> String {
        let conjugatingNumber = number % 10
        
        if conjugatingNumber < 2 {
            switch word {
            case .people:
                return "человек"
            case .vacancies:
                return "вакансия"
            }
        } else if conjugatingNumber < 5 {
            switch word {
            case .people:
                return "человека"
            case .vacancies:
                return "вакансии"
            }
        } else {
            switch word {
            case .people:
                return "человек"
            case .vacancies:
                return "вакансий"
            }
        }
    }
}
