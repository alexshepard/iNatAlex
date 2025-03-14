//
//  MyObsListView.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/10/25.
//

import SwiftUI

struct MyObsListView: View {
    @Binding var myObs: [INatObservation]

    var body: some View {
        List {
            ForEach(myObs) { observation in
                NavigationLink(destination: ObsDetailView(observation: observation)) {
                    MyObsListViewCell(observation: observation)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyObsListView(myObs: .constant([INatObservation.sample]))
    }
}
