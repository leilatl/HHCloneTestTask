//
//  FavoriteVacancyService.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 17.03.2024.
//

import CoreData
import Foundation

class FavoriteVacanciesService {
    private let context: NSManagedObjectContext
    @Published var favoriteVacancies: [VacancyModel] = []

    init(context: NSManagedObjectContext) {
        self.context = context
        favoriteVacancies = fetchAllVacancies()
    }

    func addVacancy(_ vacancyModel: VacancyModel) {
        let vacancy = Vacancy(context: context)
        vacancy.id = vacancyModel.id
        vacancy.title = vacancyModel.title
        if let lookingNumber = vacancyModel.lookingNumber {
            vacancy.lookingNumber = Int16(lookingNumber)
        }
        if let addressModel = vacancyModel.address {
            let address = Address(context: context)
            address.town = addressModel.town
            address.street = addressModel.street
            address.house = addressModel.house
            vacancy.address = address
        }
        if let company = vacancyModel.company {
            vacancy.company = company
        }
        if let experienceModel = vacancyModel.experience {
            let experience = Experience(context: context)
            experience.previewText = experienceModel.previewText
            experience.text = experienceModel.text
            vacancy.experience = experience
        }
        vacancy.publishedDate = vacancyModel.publishedDate
        vacancy.isFavorite = true
        if let salaryModel = vacancyModel.salary {
            let salary = Salary(context: context)
            salary.full = salaryModel.full
            salary.short = salaryModel.short
            vacancy.salary = salary
        }
        if let questionsArray = vacancyModel.questions {
            for questionText in questionsArray {
                let question = Question(context: context)
                question.questionText = questionText
                vacancy.addToQuestions(question)
            }
        }
        for scheduleText in vacancyModel.schedules {
            let schedule = VacancySchedule(context: context)
            schedule.scheduleText = scheduleText
            vacancy.addToSchedules(schedule)
        }
        if let appliedNumber = vacancyModel.appliedNumber {
            vacancy.appliedNumber = Int16(appliedNumber)
        }
        if let vacancyDescription = vacancyModel.vacancyDescription {
            vacancy.vacancyDescription = vacancyDescription
        }
        vacancy.responsibilities = vacancyModel.responsibilities

        do {
            try context.save()
            favoriteVacancies.append(vacancyModel)
        } catch {
            print("Error saving context: \(error)")
        }
    }

    func deleteVacancy(_ vacancyModel: VacancyModel) {
        let fetchRequest: NSFetchRequest<Vacancy> = Vacancy.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", vacancyModel.id as CVarArg)
        
        do {
            let vacanciesToDelete = try context.fetch(fetchRequest)
            for vacancy in vacanciesToDelete {
                context.delete(vacancy)
            }
            try context.save()
            favoriteVacancies = fetchAllVacancies()
        } catch {
            print("Error deleting vacancies: \(error)")
        }
    }

    private func fetchAllVacancies() -> [VacancyModel] {
        let fetchRequest: NSFetchRequest<Vacancy> = Vacancy.fetchRequest()

        do {
            let vacancies = try context.fetch(fetchRequest)
            return vacancies.map { vacancy in
                var vacancyModel = VacancyModel(
                    id: vacancy.id!,
                    lookingNumber: Int(vacancy.lookingNumber),
                    title: vacancy.title!,
                    address: nil,
                    company: vacancy.company,
                    experience: nil,
                    publishedDate: vacancy.publishedDate!,
                    isFavorite: vacancy.isFavorite,
                    salary: nil,
                    schedules: (vacancy.schedules as? Set<VacancySchedule>)?.map { $0.scheduleText! } ?? [],
                    appliedNumber: Int(vacancy.appliedNumber),
                    vacancyDescription: vacancy.vacancyDescription,
                    responsibilities: vacancy.responsibilities!,
                    questions: (vacancy.questions as? Set<Question>)?.map { $0.questionText! } ?? []
                )
                if let address = vacancy.address {
                    vacancyModel.address = AddressModel(
                        town: address.town!,
                        street: address.street!,
                        house: address.house!)
                }
                if let experience = vacancy.experience {
                    vacancyModel.experience = ExperienceModel(
                        previewText: experience.previewText!,
                        text: experience.text!)
                }
                if let salary = vacancy.salary {
                    vacancyModel.salary = SalaryModel(
                        short: salary.short ?? "",
                        full: salary.full!)
                }
                return vacancyModel
            }
        } catch {
            print("Error fetching vacancies: \(error)")
            return []
        }
    }
}
