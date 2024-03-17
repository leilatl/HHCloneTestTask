//
//  FavoritesViewModel.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 17.03.2024.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    enum Event {
        case didChooseVacancy(VacancyModel)
    }

    var onAction: ((Event) -> Void)?
    @Published var favoriteVacancies: [VacancyModel] = []
    var favoriteVacanciesService: FavoriteVacanciesService
    
    init(favoriteVacanciesService: FavoriteVacanciesService) {
        self.favoriteVacanciesService = favoriteVacanciesService
        self.favoriteVacanciesService.$favoriteVacancies.assign(to: &$favoriteVacancies)
    }
    
    func didTapFavoriteButton(vacancy: VacancyModel) {
        guard let index = favoriteVacancies.firstIndex(where: { $0.id == vacancy.id }) else { return }
        favoriteVacancies[index].isFavorite.toggle()

        if favoriteVacancies[index].isFavorite {
            favoriteVacanciesService.addVacancy(favoriteVacancies[index])
        } else {
            favoriteVacanciesService.deleteVacancy(favoriteVacancies[index])
        }
    }
}
