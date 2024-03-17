//
//  VacancyDetailView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 17.03.2024.
//

import SwiftUI

struct VacancyDetailView: View {
    @StateObject var viewModel: VacancyDetailViewModel

    var body: some View {
        VStack(spacing: 26, content: {
            topNavigationBar
            vacancyDetails
            Button(action: {
            }, label: {
                Text("Откликнуться")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.vertical, 14)
            })
            .frame(maxWidth: .infinity)
            .background(Color.theme.specialGreen)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.top, 16)
        })
        .padding(16)
        .background(Color.black)
        .navigationBarHidden(true)
    }
}

extension VacancyDetailView {
    var topNavigationBar: some View {
        HStack(spacing: 16, content: {
            Button(action: {
                viewModel.onAction?(.goBack)
            }, label: {
                Image(systemName: "arrow.left")
                    .foregroundStyle(Color.white)
            })

            Spacer()

            Button(action: {
            }, label: {
                Image.local.eyeOutline
                    .foregroundStyle(Color.white)
            })

            Button(action: {
            }, label: {
                Image.local.share
                    .foregroundStyle(Color.white)
            })

            Button(action: {
                viewModel.didTapFavoriteButton()
            }, label: {
                Image(viewModel.vacancy.isFavorite ? "heart" : "heart.outline")
                    .resizable()
                    .foregroundStyle(
                        viewModel.vacancy.isFavorite
                            ? Color.theme.specialBlue
                            : Color.theme.grayText)
                    .frame(width: 24, height: 24)
            })
        })
    }

    var vacancyDetails: some View {
        ScrollView {
            VStack(spacing: 32, content: {
                VStack(alignment: .leading, spacing: 16, content: {
                    Text(viewModel.vacancy.title)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 22, weight: .semibold))
                    Text(viewModel.vacancy.salary?.full ?? "")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 14))
                    Text("Требуемый опыт \(viewModel.vacancy.experience?.text ?? "не указан")")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 14))
                    Text("\(makeSchedulesString())")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 14))
                        .padding(.top, -10)
                })
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 8, content: {
                    if let appliedNumber = viewModel.vacancy.appliedNumber {
                        statisticsView(
                            number: appliedNumber,
                            title: "человек уже откликнулись",
                            image: Image.local.appliedNumber)
                    }
                    
                    if let lookingNumber = viewModel.vacancy.lookingNumber {
                        statisticsView(
                            number: lookingNumber,
                            title: "человека сейчас смотрят",
                            image: Image.local.lookingNumber)
                    }

                })
                .frame(maxWidth: .infinity)

                address

                Text(viewModel.vacancy.vacancyDescription ?? "")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 14))

                responsibilities

                questions
            })
        }
    }

    var questions: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Text("Задайте вопрос работодателю")
                .foregroundStyle(Color.white)
                .font(.system(size: 14, weight: .medium))

            Text("Он получит его с откликом на вакансию")
                .foregroundStyle(Color.theme.grayText)
                .font(.system(size: 14, weight: .medium))
                .padding(.top, 8)

            if let questions = viewModel.vacancy.questions {
                ForEach(questions, id: \.self) { question in
                    Text(question)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 14, weight: .medium))
                        .background(Color.theme.lightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.top, 8)
                }
                .padding(.top, 8)
            }

        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var responsibilities: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text("Ваши задачи")
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .semibold))
            Text(viewModel.vacancy.responsibilities)
                .foregroundStyle(Color.white)
                .font(.system(size: 14))
        })
    }

    var address: some View {
        VStack(alignment: .leading, content: {
            HStack(spacing: 8, content: {
                Text(viewModel.vacancy.company ?? "")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .medium))
                Image.local.checkMark
                    .foregroundStyle(Color.theme.grayText)
            })
            Image.local.map
                .resizable()
                .frame(maxWidth: .infinity)
            Text(makeAddressString())
                .foregroundStyle(Color.white)
                .font(.system(size: 14))
        })
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.darkGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    func statisticsView(number: Int, title: String, image: Image) -> some View {
        HStack(alignment: .top, content: {
            Text("\(number) \(title)")
                .foregroundStyle(Color.white)
                .font(.system(size: 14))
            Spacer()
            image
        })
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color.theme.specialDarkGreen)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension VacancyDetailView {
    func makeAddressString() -> String {
        var addressString = ""

        addressString += viewModel.vacancy.address?.town ?? ""
        addressString += ", \(viewModel.vacancy.address?.street ?? "")"
        addressString += ", \(viewModel.vacancy.address?.house ?? "")"

        return addressString
    }

    func makeSchedulesString() -> String {
        var schedulesString = ""
        var firstElementDone = false
        for schedule in viewModel.vacancy.schedules {
            if firstElementDone {
                schedulesString += ", \(schedule)"
            } else {
                schedulesString += "\(schedule.prefix(1).uppercased() + schedule.dropFirst().lowercased())"
                firstElementDone = true
            }
        }

        return schedulesString
    }
}

// #Preview {
//    VacancyDetailView(
//        viewModel: VacancyDetailViewModel(
//            vacancy:
//            VacancyModel(
//                id: "cbf0c984-7c6c-4ada-82da-e29dc698bb50",
//                lookingNumber: 2,
//                title: "UI/UX дизайнер",
//                address: Address(
//                    town: "Минск",
//                    street: "улица Бирюзова",
//                    house: "4/5"
//                ),
//                company: "Мобирикс",
//                experience:
//                    Experience(
//                        previewText: "Опыт от 1 до 3 лет",
//                        text: "1–3 года"),
//                publishedDate: "2024-02-20",
//                isFavorite: false,
//                salary: Salary(
//                    short: nil,
//                    full: "Уровень дохода не указан"
//                ),
//                schedules: [
//                    "полная занятость",
//                    "полный день",
//                ],
//                appliedNumber: 147,
//                description: "Мы ищем специалиста на позицию UX/UI Designer, который вместе с коллегами будет заниматься проектированием пользовательских интерфейсов внутренних и внешних продуктов компании.",
//                responsibilities: "- проектирование пользовательских сценариев и создание прототипов;\n- разработка интерфейсов для продуктов компании (Web+App);\n- работа над созданием и улучшением Дизайн-системы;\n- взаимодействие с командами frontend-разработки;\n- контроль качества внедрения дизайна;\n- ситуативно: создание презентаций и других материалов на основе фирменного стиля компании",
//                questions: [
//                    "Где располагается место работы?",
//                    "Какой график работы?",
//                    "Вакансия открыта?",
//                    "Какая оплата труда?",
//                ])))
// }
