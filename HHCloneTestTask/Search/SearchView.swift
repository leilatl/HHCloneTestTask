//
//  SearchView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel

    var body: some View {
        VStack(spacing: 16, content: {
            searchBar
            recommendations
            vacancies
                .padding(.top, 16)
            if viewModel.numberOfAllVacancies > 3 {
                moreVacanciesButton
            }
        })
        .padding(.horizontal, 17)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

private extension SearchView {
    var searchBar: some View {
        HStack {
            HStack {
                Image.local.magnifyingglass
                    .foregroundStyle(Color.theme.grayText)
                Text("Должность, ключевые слова")
                    .foregroundStyle(Color.theme.grayText)
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(8)
            .background(Color.theme.lightGray)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Image.local.slider
                .foregroundStyle(Color.white)
                .padding(8)
                .background(Color.theme.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

    var recommendations: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                recommendation(
                    image: Image.local.vacanciesNear,
                    title: "Вакансии рядом с вами",
                    hasButton: false)
                recommendation(
                    image: Image.local.raiseCV,
                    title: "Поднять резюме в поиске",
                    hasButton: true)
                recommendation(
                    image: Image.local.temporaryJob,
                    title: "Временная работа и подработка",
                    hasButton: false)
            }
        }
    }

    func recommendation(image: Image, title: String, hasButton: Bool) -> some View {
        VStack(alignment: .leading, content: {
            image
            Text(title)
                .foregroundStyle(Color.white)
                .font(.system(size: 14, weight: .medium))
            if hasButton {
                Text("Поднять")
                    .foregroundStyle(Color.green)
                    .font(.system(size: 14))
            }
            Spacer()
        })
        .padding(.horizontal, 6)
        .padding(.vertical, 10)
        .frame(width: 132, height: 120, alignment: .leading)
        .background(Color.theme.darkGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    var vacancies: some View {
        VStack(spacing: 0) {
            Text("Вакансии для вас")
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.vacancies) { vacancy in
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
    
    var moreVacanciesButton: some View {
        Button(action: {
        }, label: {
            Text("""
            Еще \
            \(viewModel.numberOfAllVacancies - 3) \
            \(ConjugationService.conjugate(
            word: .vacancies,
            number: viewModel.numberOfAllVacancies - 3))
            """)
            .foregroundStyle(Color.white)
            .font(.system(size: 16, weight: .semibold))
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(Color.theme.specialBlue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        })
    }
}
