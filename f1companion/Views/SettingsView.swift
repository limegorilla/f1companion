//
//  SettingsView.swift
//  f1companion
//
//  Created by Liam Doyle on 01/11/2022.
//  Copyright © 2022 limegorilla. All rights reserved.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    

    
    @AppStorage("favoriteDriver") var favoriteDriver = "Select"
    @AppStorage("favoriteTeam") var favoriteTeam = "Select"
    @AppStorage("liveActivityOnRace") var liveActivityOnRace = false
    
    @State var enableNotifications = false
    

    let drivers = ["Select", "Charles Leclerc", "Max Verstappen", "Lando Norris"]
    let teams = ["Select", "Red Bull RBPT", "Mercedes AMG PETRONAS", "Aston Martin", "Haas F1 Team"]
    
    var body: some View {
        NavigationView() {
            Form {
                Section {
                    Picker("Favorite Driver", selection: $favoriteDriver) {
                        ForEach(drivers, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Favorite Team", selection: $favoriteTeam) {
                        ForEach(teams, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Your Favorites ❤️")
                }
                
                Section {
                    Toggle(isOn: $liveActivityOnRace) {
                        Text("Live Activities")
                        Text("Get all the action on your lockscreen and on the Dynamic Island of supported devices")
                            .font(.caption)
                    }
                    Toggle(isOn: $enableNotifications) {
                        Text("Enable Notifications")
                    }.onChange(of: enableNotifications) { value in
                        if (value == true) {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("All set!")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                } header: {
                    Text("Notifications & Live Activities")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
