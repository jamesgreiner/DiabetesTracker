//
//  TabHeaderView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 12/21/23.
//

import SwiftUI

struct TabHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
//            Image(systemName: "drop.fill")
//                .resizable()
//                .frame(width: 30, height: 50)
//                .padding(.horizontal)
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Gradient(colors: [Color.theme.accent.opacity(0.5), Color.theme.background]))
    }
}

#Preview {
    TabHeaderView(title: "Glucose")
}
