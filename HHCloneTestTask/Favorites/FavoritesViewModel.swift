//
//  FavoritesViewModel.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 17.03.2024.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoriteVacancies: [VacancyModel] = []
    var favoriteVacanciesService: FavoriteVacanciesService
    
    init(favoriteVacanciesService: FavoriteVacanciesService) {
        self.favoriteVacanciesService = favoriteVacanciesService
        self.favoriteVacanciesService.$favoriteVacancies.assign(to: &$favoriteVacancies)
    }
}
