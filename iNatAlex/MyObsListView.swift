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
                MyObsListViewCell(observation: observation)
            }
        }
    }
}

#Preview {
    MyObsListView(myObs: .constant([]))
}
