//
//  ContentView.swift
//  f1companion
//
//  Created by Liam Doyle on 31/10/2022.
//

import SwiftUI

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


struct ContentView: View {

    @State private var results = [Meeting]()

    var body: some View {
        NavigationView {
            List(results, id: \.Key) { item in
                VStack(alignment: .leading) {
                    Text(item.OfficialName)
                        .font(.headline)
                    Text(item.Location)
                    ForEach(item.Sessions, id: \.Key) { meeting in
                        Text(meeting.`Type`)
                    }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
