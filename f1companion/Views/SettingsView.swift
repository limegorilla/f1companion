//
//  SettingsView.swift
//  f1companion
//
//  Created by Liam Doyle on 01/11/2022.
//  Copyright © 2022 limegorilla. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("favoriteDriver") var favoriteDriver = "Charles Leclerc"
    
    let drivers = ["Charles Leclerc", "Max Verstappen", "Lando Norris"]
    let teams = ["Red Bull RBPT"]
    
    var body: some View {
        NavigationView() {
            Form {
                Text("hello")
                
                Picker("Favorite Driver", selection: $favoriteDriver) {
                    ForEach(drivers, id: \.self) {
                        Text($0)
                    }
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
