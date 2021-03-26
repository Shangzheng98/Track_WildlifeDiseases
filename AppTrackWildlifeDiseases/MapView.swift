//
//  MapView.swift
//  TrackDiseases
//
//  Created by Shangzheng Ji on 3/25/21.
//  Copyright © 2021 Team1. All rights reserved.
//

import SwiftUI

struct MapView: View {
    @Binding var latitude : Double
    @Binding var longtitude: Double
    var locationLat:Double
    var locationLong:Double
    
    @State private var showTutorial = false
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Button(action: {
                    showTutorial = true
                }, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
            }
            
            map(latitude: latitude, longtitude: longtitude, locationLat: locationLat, locationLong: locationLong)

        }
    }
}


