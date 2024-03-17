//
//  FavoritesView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    
    var body: some View {
        VStack {
            Text("Favorites")
                .foregroundStyle(Color.white)
        }
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
