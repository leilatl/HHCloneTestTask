//
//  EmtyView.swift
//  HHCloneTestTask
//
//  Created by Leila Serebrova on 16.03.2024.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Text("Empty View")
                .frame(maxWidth: .infinity)
            Spacer()
        }
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
