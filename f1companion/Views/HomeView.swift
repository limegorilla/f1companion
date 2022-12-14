//
//  HomeView.swift
//  f1companion
//
//  Created by Liam Doyle on 01/11/2022.
//  Copyright © 2022 limegorilla. All rights reserved.
//

import SwiftUI

// Data Types
struct Response: Codable {
    let Year: Int
    let Meetings: [Meeting]
}

struct Meeting: Codable {
    let Key: Int
    let Code: String
    let OfficialName: String
    let Location: String
    let Sessions: [Session]
}

struct Session: Codable {
    let Key: Int
    let `Type`: String
}

struct HomeView: View {

    @State private var results = [Meeting]()

    var body: some View {
        
         NavigationView {
            List {
                            Section {
                                ForEach(results, id: \.Key) { result in
                                    VStack(alignment: .leading) {
                                        Text(result.Location)
                                            .font(.headline)
                                        Text(result.OfficialName)
                                            .font(.caption2)
                                    }
                                }
                            } header: {
                                Text("2022 Races")
                            }
                        }
                        .task {
                            await loadData()
                            // Waits for loadData (network req) to complete before loading UI
                        }
                        .navigationTitle("Previous Races")
                        .navigationBarTitleDisplayMode(.automatic)
                    }
        
    }
    func loadData() async {
    
        guard let url = URL(string: "https://livetiming.formula1.com/static/2022/Index.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            print(data)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.Meetings
            }
        } catch {
            print("Invalid data")
        }
    }
}
