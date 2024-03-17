//
//  VacancyModel.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import Foundation

struct Response: Decodable {
    let vacancies: [VacancyModel]
}

struct VacancyModel: Decodable, Identifiable {
    let id: UUID
    let lookingNumber: Int?
    let title: String
    var address: AddressModel?
    let company: String?
    var experience: ExperienceModel?
    let publishedDate: String
    var isFavorite: Bool
    var salary: SalaryModel?
    let schedules: [String]
    let appliedNumber: Int?
    let vacancyDescription: String?
    let responsibilities: String
    let questions: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case lookingNumber
        case title
        case address
        case company
        case experience
        case publishedDate
        case isFavorite
        case salary
        case schedules
        case appliedNumber
        case vacancyDescription = "description" // Mapping from JSON
        case responsibilities
        case questions
    }
}

struct AddressModel: Decodable {
    let town: String
    let street: String
    let house: String
}

struct ExperienceModel: Decodable {
    let previewText: String
    let text: String
}

struct SalaryModel: Decodable {
    let short: String?
    let full: String?
}
