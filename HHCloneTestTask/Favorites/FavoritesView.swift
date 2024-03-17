//
//  FavoritesView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            title
            favoriteVacanciesList
        })
        .padding(16)
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension FavoritesView {
    var title: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Избранное")
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(viewModel.favoriteVacancies.count) вакансия")
                .foregroundStyle(Color.theme.grayText)
                .font(.system(size: 14))
                .padding(.top, 24)
        }
    }
    
    var favoriteVacanciesList: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.favoriteVacancies) { vacancy in
                    VacancyView(vacancyModel: vacancy, onFavoriteButtonTap: {
                        viewModel.didTapFavoriteButton(vacancy: vacancy)
                    })
                    .onTapGesture {
                        viewModel.onAction?(.didChooseVacancy(vacancy))
                    }
                }
            }
        }
        .padding(.top, 16)
    }
}
