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
                .tabItem { glucoseTab }
            CarbsView()
                .tabItem { carbohydratesTab }
            MedicationsView()
                .tabItem { medicationsTab }
            RemindersView()
                .tabItem { remindersTab }
            SettingsView()
                .tabItem { settingsTab }
        }
    }
}

extension HomeView {
    // MARK: View components
    private var glucoseTab: some View {
        Label("Glucose", systemImage: "drop.fill")
    }
    
    private var carbohydratesTab: some View {
        Label("Carbohydrates", systemImage: "fork.knife.circle.fill")
    }
    
    private var medicationsTab: some View {
        Label("Medications", systemImage: "syringe.fill")
    }
    
    private var remindersTab: some View {
        Label("Reminders", systemImage: "alarm.fill")
    }
    
    private var settingsTab: some View {
        Label("Settings", systemImage: "gear.circle.fill")
    }
}

#Preview {
    HomeView()
}
