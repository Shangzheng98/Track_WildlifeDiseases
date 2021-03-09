//
//  Description.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI

struct Description: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "square.fill")
                    .foregroundColor(Color("Chicago Maroon"))
                Text("Project Descrition")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Link(destination:URL(string:webpageURL)!) {
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                        .imageScale(.small)
                    
                }
            }
            
            .padding(.bottom)
            
            
            Text(descriptionContent)
                .multilineTextAlignment(.leading)
        }
        .padding([.leading,.top])
        
        
        
        
        
    }
}

struct Description_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Description()
            
        }
    }
}
