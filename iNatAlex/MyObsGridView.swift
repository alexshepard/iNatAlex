//
//  MyObsGridView.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/10/25.
//

import SwiftUI

struct MyObsGridView: View {
    @Binding var myObs: [INatObservation]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        GeometryReader { geom in
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(myObs) { observation in
                        if let photoURL = observation.observationPhotos.first?.photo.smallUrl {
                            AsyncImage(url: photoURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geom.size.width / 3, height: geom.size.width / 3)
                                    .clipShape(RoundedRectangle(cornerRadius: 3.0))
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                                    .frame(width: geom.size.width / 3, height: geom.size.width / 3)
                            }
                        } else {
                            Text("No Photo")
                                .frame(width: geom.size.width / 3, height: geom.size.width / 3)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MyObsGridView(myObs: .constant([]))
}
