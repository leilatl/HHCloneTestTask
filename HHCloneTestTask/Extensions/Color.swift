//
//  UIColor.swift
//  Ploffe_SwiftUI
//
//  Created by Leila Serebrova on 08.02.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let text = Color("TextColor")
    let gradientStart = Color("GradientStartColor")
    let gradientEnd = Color("GradientEndColor")
    let orangeColor = Color("OrangeColor")
    let specialBlue = Color("SpecialBlue")
    let darkGray = Color("DarkGray")
    let lightGray = Color("LightGray")
    let grayText = Color("GrayText")
    let specialGreen = Color("SpecialGreen")
    let specialDarkGreen = Color("SpecialDarkGreen")
}
