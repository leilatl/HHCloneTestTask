//
//  CodeInputView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 17.03.2024.
//

import Foundation
import SwiftUI

struct CodeInputView: View {
    @Binding var digit1: String
    @Binding var digit2: String
    @Binding var digit3: String
    @Binding var digit4: String

    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case field1, field2, field3, field4
    }

    var body: some View {
        HStack {
            Group {
                SingleDigitTextField(
                    text: $digit1,
                    nextField: .field2,
                    currentField: .field1,
                    focusedField: _focusedField
                )
                SingleDigitTextField(
                    text: $digit2,
                    previousField: .field1,
                    nextField: .field3,
                    currentField: .field2,
                    focusedField: _focusedField
                )
                SingleDigitTextField(
                    text: $digit3,
                    previousField: .field2,
                    nextField: .field4,
                    currentField: .field3,
                    focusedField: _focusedField
                )
                SingleDigitTextField(
                    text: $digit4,
                    previousField: .field3,
                    currentField: .field4,
                    focusedField: _focusedField
                )
            }
            .frame(width: 48, height: 48)
            .background(Color.theme.lightGray)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .font(.title)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
        }
        .onAppear {
            focusedField = .field1
        }
    }
}

struct SingleDigitTextField: View {
    @Binding var text: String
    var previousField: CodeInputView.Field? = nil
    var nextField: CodeInputView.Field? = nil
    var currentField: CodeInputView.Field? = nil
    @FocusState var focusedField: CodeInputView.Field?

    var body: some View {
        ZStack {
            Image(systemName: "staroflife.fill")
                .foregroundStyle(Color.theme.grayText)
                .font(.system(size: 10))
                .opacity(
                    focusedField == currentField || !text.isEmpty ? 0 : 1
                )
            TextField("", text: $text)
                .foregroundStyle(Color.white)
                .onChange(of: text, { _, newValue in
                    let filtered = newValue.filter { $0.isNumber }

                    if filtered != newValue {
                        text = filtered
                    }
                    if filtered.count > 1 {
                        text = String(newValue.last ?? Character(""))
                    }

                    if !filtered.isEmpty {
                        focusedField = nextField
                    }
                })
                .keyboardType(.numberPad)
                .focused($focusedField, equals: currentField)
        }
    }
}
