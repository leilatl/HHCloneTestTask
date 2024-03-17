//
//  EntryView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 15.03.2024.
//

import Foundation
import SwiftUI

struct EntryView: View {
    @StateObject var viewModel: EntryViewModel
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Вход в личный кабинет")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }

            VStack(spacing: 18, content: {
                searchJob
                searchEmployees
            })
        }
        .padding(16)
        .background(Color.black)
    }
}

extension EntryView {
    var searchJob: some View {
        VStack(spacing: 16, content: {
            Text("Поиск Работы")
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
            emailTextField

            HStack {
                Button(action: {
                    viewModel.onAction?(.next(viewModel.email))
                }, label: {
                    Text("Продолжить")
                        .foregroundStyle(
                            Color.white.opacity(
                                viewModel.isEmailValid ? 1 : 0.5
                            )
                        )
                        .padding(11)
                })
                .disabled(!viewModel.isEmailValid)
                .frame(maxWidth: .infinity)
                .background(
                    Color.theme.specialBlue.opacity(
                        viewModel.isEmailValid ? 1 : 0.5
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Button(action: {
                }, label: {
                    Text("Войти с паролем")
                        .foregroundStyle(Color.theme.specialBlue)
                })
                .frame(maxWidth: .infinity)
            }
        })
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .background(Color.theme.darkGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    var emailTextField: some View {
        ZStack(alignment: .leading) {
            if !isTextFieldFocused && viewModel.email.isEmpty {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundStyle(Color.theme.grayText)
                    Text("Enter your email")
                        .foregroundColor(Color.theme.grayText)
                    Spacer()
                }
            }

            TextField("", text: $viewModel.email)
                .focused($isTextFieldFocused)
                .foregroundColor(Color.white)
                .tint(Color.theme.grayText)
                .padding(.leading, isTextFieldFocused || !viewModel.email.isEmpty ? 0 : 30)

            if isTextFieldFocused && !viewModel.email.isEmpty {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.viewModel.email = ""
                    }, label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                    })
                }
            }
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }

    var searchEmployees: some View {
        VStack(spacing: 8, content: {
            Text("Поиск сотрудников")
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Размещение вакансий и доступ к базе резюме")
                .foregroundStyle(Color.white)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: {
            }, label: {
                Text("Я ищу сотрудников")
                    .foregroundStyle(Color.white)
                    .padding(11)
            })
            .frame(maxWidth: .infinity)
            .background(Color.theme.specialGreen)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .padding(.top, 8)
        })
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .background(Color.theme.darkGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
