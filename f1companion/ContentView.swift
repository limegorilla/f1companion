//
//  ContentView.swift
//  f1companion
//
//  Created by Liam Doyle on 31/10/2022.
//

import SwiftUI




struct ContentView: View {

    @State private var results = [Meeting]()
    

    var body: some View {
        TabView() {
                
                // Home
                HomeView()
                    .tabItem() {
                        Label("Home", systemImage: "house")
                    }
                
                // Settings
                SettingsView()
                .tabItem() {
                    Label("Settings", systemImage: "gear")
                }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




