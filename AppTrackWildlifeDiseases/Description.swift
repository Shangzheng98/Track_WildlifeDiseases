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
            Link(destination:URL(string:webpageURL)!) {
                Text("Project Descrition")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
            }
            
            Text(descriptionContent)
                .multilineTextAlignment(.leading)
        }
        
        
        
        
        
    }
}

struct Description_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Description()
            
        }
    }
}
