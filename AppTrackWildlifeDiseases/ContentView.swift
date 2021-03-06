//
//  ContentView.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AboutUs()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("AboutUs")
                }
            PictureTakeing()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Upload")
                }
            HistoryView()
                .tabItem{
                    Image(systemName: "doc.on.doc")
                    Text("History")
                }
        }
        .accentColor(Color("Burnt Orange"))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
