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
                    HStack {
                        if let photoURL = observation.observationPhotos.first?.photo.smallUrl {
                            AsyncImage(url: photoURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            }

                        } else {
                            Text("No Photo")
                                .frame(width: 100, height: 100)
                        }
                        VStack {
                            Text(observation.id.uuidString)
                        }
                    }
                }
            }
            .navigationTitle("alexshepard")
            .task {
                let url = URL(string: "https://api.inaturalist.org/v1/observations?user_login=alexshepard&order=desc&order_by=created_at")!
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

                    let resp = try jsonDecoder.decode(ObsFetchResponse.self, from: data)

                    self.myObs = resp.results
                } catch {
                    print(error)
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
