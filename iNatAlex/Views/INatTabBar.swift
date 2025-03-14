//
//  INatTabBar.swift
//  iNatAlex
//
//  Created by Alex Shepard on 3/4/25.
//

import SwiftUI

struct INatTabBar: View {
    var body: some View {
        TabView {
            Text("Explore")
                .tabItem {
                    Label("Explore", systemImage: "globe.asia.australia")
                }
            Text("New")
                .tabItem {
                    Label("New Observation", systemImage: "camera")
                }

            MyObsView()
        }
    }
}

#Preview {
    INatTabBar()
}
