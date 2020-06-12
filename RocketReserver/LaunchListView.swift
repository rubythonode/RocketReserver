//
//  LaunchListView.swift
//  RocketReserver
//
//  Created by Mookyung Kwak on 2020/06/12.
//  Copyright © 2020 Mookyung Kwak. All rights reserved.
//

import SwiftUI

struct LaunchListView: View {
    @EnvironmentObject var store: ObjectStore

    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    Section(
                        footer: LoadMoreButton()
                            .environmentObject(self.store)
                    ) {
                        ForEach(self.store.launches) { launch in
                            NavigationLink(
                                destination:
                                    LaunchDetailView(
                                        id: launch.id,
                                        site: launch.site
                                    )
                                    .environmentObject(self.store)
                                )
                                {
                                    LaunchRowView(launch: launch)
                                }
                        }
                    }
                }
                
            }
            .navigationBarTitle("Launches")
            .onAppear() {
                self.store.loadLaunches()
            }
        }
    }
}

struct LoadMoreButton: View {
    @EnvironmentObject var store: ObjectStore
    
    var body: some View {
        self.store.lastConnection?.hasMore ?? false ?
            (self.store.activeRequest == nil) ?
                Button("Tap to load more", action: {
                    self.store.loadLaunches()
                })
            :
                nil
        :
            nil
    }
}
