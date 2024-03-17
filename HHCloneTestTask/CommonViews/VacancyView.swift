//
//  VacancyView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import SwiftUI

struct VacancyView: View {
    var vacancyModel: VacancyModel
    let onFavoriteButtonTap: () -> Void
    var body: some View {
        VStack(spacing: 21, content: {
            ZStack(alignment: .topTrailing, content: {
                heartButton
                VStack(alignment: .leading, spacing: 10, content: {
                    if let lookingNumber = vacancyModel.lookingNumber {
                        lookingNumberText(number: lookingNumber)
                    }
                    vacancyInfo
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            })

            respondButton

        })
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.theme.darkGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

private extension VacancyView {
    var heartButton: some View {
        Button(action: {
            onFavoriteButtonTap()
        }, label: {
            Image(vacancyModel.isFavorite ? "heart" : "heart.outline")
                .resizable()
                .foregroundStyle(
                    vacancyModel.isFavorite
                        ? Color.theme.specialBlue
                        : Color.theme.grayText)
                .frame(width: 24, height: 24)
        })
    }

    func lookingNumberText(number: Int) -> some View {
        Text(
            """
            Сейчас просматривает \
            \(number) \
            \(ConjugationService.conjugate(word: .people, number: number))
            """)
            .foregroundStyle(Color.theme.specialGreen)
            .font(.system(size: 14))
    }

    var vacancyInfo: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(vacancyModel.title)
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .medium))
            VStack(alignment: .leading, spacing: 0, content: {
                Text(vacancyModel.address?.town ?? "")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 14))

                HStack(spacing: 8, content: {
                    Text(vacancyModel.company ?? "")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 14))
                    Image.local.checkMark
                        .foregroundStyle(Color.theme.grayText)
                })
            })

            HStack(spacing: 8, content: {
                Image.local.bag
                    .foregroundStyle(Color.theme.grayText)
                Text(vacancyModel.experience?.previewText ?? "")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 14))
            })

            if let dateString = getDateString() {
                Text("Опубликовано \(dateString)")
                    .foregroundStyle(Color.theme.grayText)
                    .font(.system(size: 14))
            }
        })
    }

    var respondButton: some View {
        Button(action: {
        }, label: {
            Text("Откликнуться")
                .foregroundStyle(Color.white)
                .font(.system(size: 14))
                .padding(7)
                .frame(maxWidth: .infinity)
                .background(Color.theme.specialGreen)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        })
    }
}

private extension VacancyView {
    func getDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = inputFormatter.date(from: vacancyModel.publishedDate) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ru_RU")
        outputFormatter.dateFormat = "d MMMM"

        return outputFormatter.string(from: date)
    }
}
