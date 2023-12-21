//
//  HomeView.swift
//  DiabetesTracker
//
//  Created by James Greiner on 12/15/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            GlucoseView()
                .tabItem {
                    Label("Glucose", systemImage: "drop.fill")
                }
            ContentView()
                .tabItem {
                    Label("Temp", systemImage: "gear")
                }
        }
    }
}

#Preview {
    HomeView()
}
