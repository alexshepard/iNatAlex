//
//  MyObs.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/5/25.
//

import SwiftUI

enum ViewDisplayMode: Int, CaseIterable, Identifiable {
    case list
    case grid

    var id: Int { rawValue }

    var systemImage: String {
        switch (self) {
        case .list: return "list.bullet"
        case .grid: return "square.grid.2x2"
        }
    }
}

struct MyObs: View {
    @State private var myObs = [INatObservation]()
    @State private var viewDisplayMode: ViewDisplayMode = .list

    var body: some View {
        NavigationStack {
            Group {
                switch viewDisplayMode {
                case .list:
                    MyObsListView(myObs: $myObs)
                case .grid:
                    MyObsGridView(myObs: $myObs)
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
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Picker("View Display Mode", selection: $viewDisplayMode) {
                        ForEach(ViewDisplayMode.allCases) { mode in
                            Label {
                                Text("")
                            } icon: {
                                Image(systemName: mode.systemImage)
                            }
                            .tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)
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
