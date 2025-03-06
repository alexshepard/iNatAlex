//
//  MyObsListViewCell.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/6/25.
//

import SwiftUI

struct MyObsListViewCell: View {
    @State var observation: INatObservation

    var body: some View {
        HStack(spacing: 10) {
            if let photoURL = observation.observationPhotos.first?.photo.smallUrl {
                AsyncImage(url: photoURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            } else {
                Text("No Photo")
                    .frame(width: 100, height: 100)
            }
            VStack(alignment: .leading) {
                Text(observation.taxonDisplayName)
                Text(observation.dateDisplayText)
            }
        }
    }
}

#Preview {
    MyObsListViewCell(observation: INatObservation(uuid: UUID(), observationPhotos: []))
}
