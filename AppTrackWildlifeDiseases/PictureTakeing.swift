//
//  PictureTakeing.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI

struct PictureTakeing: View {
    var body: some View {
        VStack {
            HStack() {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .center) {
                    Text("Luis E. Escobar")
                        .font(.title)
                    Text("Asst Professor AY")
                        .font(.title2)
                        
                    HStack {
                        Image(systemName: "envelope")
                        Text(email)
                    }
                        
                }
            }
        }
    }
}

struct PictureTakeing_Previews: PreviewProvider {
    static var previews: some View {
        PictureTakeing()
    }
}
