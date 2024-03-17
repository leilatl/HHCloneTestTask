//
//  Image.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 17.03.2024.
//

import Foundation
import SwiftUI

extension Image {
    static let local = LocalImages()
}

struct LocalImages {
    let appliedNumber = Image("appliedNumber")
    let bag = Image("bag")
    let checkMark = Image("check.mark")
    let cross = Image("cross")
    let envelope = Image("envelope")
    let eyeOutline = Image("eye.outline")
    let heart = Image("heart")
    let heartOutline = Image("heart.outline")
    let lookingNumber = Image("lookingNumber")
    let magnifyingglass = Image("magnifyingglass")
    let map = Image("map")
    let messages = Image("messages")
    let profile = Image("profile")
    let raiseCV = Image("raiseCV")
    let share = Image("share")
    let slider = Image("slider")
    let temporaryJob = Image("temporaryJob")
    let vacanciesNear = Image("vacanciesNear")
}
