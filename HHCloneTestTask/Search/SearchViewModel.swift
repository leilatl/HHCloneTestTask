//
//  SearchViewModel.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    enum Event {
        case didChooseVacancy(VacancyModel)
    }

    var onAction: ((Event) -> Void)?
    @Published var vacancies: [VacancyModel] = []
    @Published var numberOfAllVacancies: Int = 0
    var vacancyProvider: VacancyProvider
    var favoriteVacanciesService: FavoriteVacanciesService
    private var cancellables = Set<AnyCancellable>()

    init(vacancyProvider: VacancyProvider, favoriteVacanciesService: FavoriteVacanciesService) {
        self.vacancyProvider = vacancyProvider
        self.favoriteVacanciesService = favoriteVacanciesService

        vacancyProvider.$vacancies
            .map { $0.count }
            .assign(to: &$numberOfAllVacancies)

        vacancyProvider.$vacancies
            .map { Array($0.prefix(3)) }
            .assign(to: &$vacancies)

        self.favoriteVacanciesService.$favoriteVacancies
            .receive(on: RunLoop.main)
            .sink { [weak self] updatedFavorites in
                self?.updateFavorites(updatedFavorites)
            }
            .store(in: &cancellables)
    }
    
    private func updateFavorites(_ favorites: [VacancyModel]) {
        for (index, vacancy) in vacancies.enumerated() {
            if let matchingFavorite = favorites.first(where: { $0.id == vacancy.id }) {
                vacancies[index].isFavorite = matchingFavorite.isFavorite
            } else {
                vacancies[index].isFavorite = false
            }
        }
    }

    func didTapFavoriteButton(vacancy: VacancyModel) {
        guard let index = vacancies.firstIndex(where: { $0.id == vacancy.id }) else { return }
        vacancies[index].isFavorite.toggle()

        if vacancies[index].isFavorite {
            favoriteVacanciesService.addVacancy(vacancies[index])
        } else {
            favoriteVacanciesService.deleteVacancy(vacancies[index])
        }
        // print(favoriteVacanciesService.fetchAllVacancies())
        // print(favoriteVacanciesService.fetchAllVacancies().count)
    }
}
