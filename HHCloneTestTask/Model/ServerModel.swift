//
//  ServerModel.swift
//  Ploffe_SwiftUI
//
//  Created by Leila Serebrova on 08.02.2024.
//

import Foundation
import SwiftUI
class ServerModelUIO: ObservableObject, Identifiable {
    enum Speed {
        case low, medium, fast

        var image: Image {
            switch self {
            case .low:
                Image("speed_low")
            case .medium:
                Image("speed_average")
            case .fast:
                Image("speed_fast")
            }
        }
    }

    @Published var countryName: String = ""
    @Published var countryImage: Image = Image("flag_germany")
    @Published var cityName: String = ""
    @Published var speed: Speed = .fast
    
    init(countryName: String, countryImage: Image, cityName: String, speed: Speed) {
        self.countryName = countryName
        self.countryImage = countryImage
        self.cityName = cityName
        self.speed = speed
    }
}
