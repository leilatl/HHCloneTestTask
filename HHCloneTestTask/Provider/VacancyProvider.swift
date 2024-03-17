//
//  VacancyProvider.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import Combine
import Foundation

class VacancyProvider {
    @Published var vacancies: [VacancyModel] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchVacancies()
    }

    private func fetchVacancies() {
        guard let url = URL(string: "https://run.mocky.io/v3/ed41d10e-0c1f-4439-94fa-9702c9d95c14") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .map(\.vacancies)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] receivedVacancies in
                self?.vacancies = receivedVacancies
            })
            .store(in: &cancellables)
    }
}
