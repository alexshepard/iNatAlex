//
//  MyObs.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/5/25.
//

import SwiftUI

struct MyObs: View {
    @State private var myObs = [INatObservation]()

    var body: some View {
        NavigationStack {
            List {
                ForEach(myObs) { observation in
                    MyObsListViewCell(observation: observation)
                }
            }
            .navigationTitle("alexshepard")
            .task {
                let url = URL(string: "https://api.inaturalist.org/v1/observations?user_login=alexshepard&order=desc&order_by=created_at")!
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    jsonDecoder.dateDecodingStrategy = .iso8601

                    let resp = try jsonDecoder.decode(ObsFetchResponse.self, from: data)

                    self.myObs = resp.results
                } catch {
                    print(error)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        // show messages
                    } label: {
                        Label("Messages", systemImage: "tray.full")
                    }

                    Button {
                        // show settings
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
        }
        .tabItem {
            Label("Me", systemImage: "person")
        }

    }
}

#Preview {
    MyObs()
}
