//
//  SecurityCodeView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import Combine
import SwiftUI

struct SecurityCodeView: View {
    @StateObject var viewModel: SecurityCodeViewModel

    @State private var digit1: String = ""
    @State private var digit2: String = ""
    @State private var digit3: String = ""
    @State private var digit4: String = ""

    private var isButtonEnabled: Bool {
        !digit1.isEmpty && !digit2.isEmpty
            && !digit3.isEmpty && !digit4.isEmpty
    }

    var body: some View {
        VStack(spacing: 16) {
            title
            codeInput
            confirmButton
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarHidden(true)
    }
}

private extension SecurityCodeView {
    var title: some View {
        VStack(spacing: 16) {
            Text("Отправили код на \(viewModel.email)")
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет")
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var codeInput: some View {
        CodeInputView(
            digit1: $digit1,
            digit2: $digit2,
            digit3: $digit3,
            digit4: $digit4)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var confirmButton: some View {
        Button {
            viewModel.onAction?(.next)
        } label: {
            Text("Подтвердить")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 13)
                .foregroundStyle(Color.white.opacity(
                    isButtonEnabled ? 1 : 0.5
                ))
                .background(Color.theme.specialBlue.opacity(
                    isButtonEnabled ? 1 : 0.5
                ))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .disabled(!isButtonEnabled)
    }
}
