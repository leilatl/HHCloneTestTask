//
//  VacancyView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import SwiftUI

struct VacancyView: View {
    var vacancyModel: VacancyModel
    let onFavoriteButtonTap: () -> ()
    var body: some View {
        VStack(spacing: 21, content: {
            ZStack(alignment: .topTrailing, content: {
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
                VStack(alignment: .leading, spacing: 10, content: {
                    if let lookingNumber = vacancyModel.lookingNumber {
                        Text("Сейчас просматривает \(lookingNumber) человек")
                            .foregroundStyle(Color.theme.specialGreen)
                            .font(.system(size: 14))
                    }

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
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            

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
            
        })
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.theme.darkGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension VacancyView {
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

//#Preview {
//    VacancyView(vacancyModel: VacancyModel(
//        id: UUID(),
//        lookingNumber: 2,
//        title: "UI/UX дизайнер",
//        address: AddressModel(
//            town: "Минск",
//            street: "улица Бирюзова",
//            house: "4/5"),
//        company: "Мобирикс",
//        experience: ExperienceModel(
//            previewText: "Опыт от 1 до 3 лет",
//            text: "1–3 года"
//        ),
//        publishedDate: "2024-02-20",
//        isFavorite: true,
//        salary: SalaryModel(
//            short: nil,
//            full: "Уровень дохода не указан"
//        ),
//        schedules: [
//            "полная занятость",
//            "полный день",
//        ],
//        appliedNumber: 147,
//        vacancyDescription: "Мы ищем специалиста на позицию UX/UI Designer, который вместе с коллегами будет заниматься проектированием пользовательских интерфейсов внутренних и внешних продуктов компании.",
//        responsibilities: "- проектирование пользовательских сценариев и создание прототипов;\n- разработка интерфейсов для продуктов компании (Web+App);\n- работа над созданием и улучшением Дизайн-системы;\n- взаимодействие с командами frontend-разработки;\n- контроль качества внедрения дизайна;\n- ситуативно: создание презентаций и других материалов на основе фирменного стиля компании",
//        questions: [
//            "Где располагается место работы?",
//            "Какой график работы?",
//            "Вакансия открыта?",
//            "Какая оплата труда?",
//        ]), onFavoriteButtonTap: {
//            
//        })
//}
