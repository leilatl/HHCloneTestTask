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
            respondButton
        })
        .padding(16)
        .background(Color.black)
        .navigationBarHidden(true)
    }
}

private extension VacancyDetailView {
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
                            title: "\(ConjugationService.conjugate(word: .people, number: appliedNumber)) уже откликнулись",
                            image: Image.local.appliedNumber)
                    }
                    
                    if let lookingNumber = viewModel.vacancy.lookingNumber {
                        statisticsView(
                            number: lookingNumber,
                            title: "\(ConjugationService.conjugate(word: .people, number: lookingNumber))  сейчас смотрят",
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
    
    var respondButton: some View {
        Button(action: {
        }, label: {
            Text("Откликнуться")
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .semibold))
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(Color.theme.specialGreen)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        })
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

private extension VacancyDetailView {
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
