//
//  TabBarView.swift
//  Kopi Pagi
//
//  Created by Rinaldi LNU on 30/09/21.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
                    Text("Tab Content 1")
                        .tabItem {
                            Image(systemName: selectedTab == 1 ? "list.dash" : "list.dash")
                            Text("List")
                        }
                        .tag(1)
                    Text("Tab Content 2")
                        .tabItem {
                            Image(systemName: selectedTab == 2 ? "gearshape.fill" : "gearshape")
                            Text("Settings")
                        }
                        .tag(2)
                })
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
