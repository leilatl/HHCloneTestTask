//
//  VacancyDetailViewModel.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 17.03.2024.
//

import Foundation
class VacancyDetailViewModel: ObservableObject {
    enum Event {
        case goBack
    }

    var onAction: ((Event) -> Void)?
    @Published var vacancy: VacancyModel
    var favoriteVacanciesService: FavoriteVacanciesService
    
    init(vacancy: VacancyModel, favoriteVacanciesService: FavoriteVacanciesService) {
        self.vacancy = vacancy
        self.favoriteVacanciesService = favoriteVacanciesService
    }
    
    func didTapFavoriteButton() {
        vacancy.isFavorite.toggle()

        if vacancy.isFavorite {
            favoriteVacanciesService.addVacancy(vacancy)
        } else {
            favoriteVacanciesService.deleteVacancy(vacancy)
        }
    }
    
}
