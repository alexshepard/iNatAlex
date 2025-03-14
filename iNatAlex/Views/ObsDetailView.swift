//
//  ObsDetailView.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/13/25.
//

import SwiftUI

struct ObsDetailView: View {
    var observation: INatObservation
    var body: some View {
        List {
            Text(observation.taxonDisplayName)
            Text(observation.dateDisplayText)
        }
    }
}

#Preview {
    return ObsDetailView(observation: INatObservation.sample)
}
