//
//  MangeDescription.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/23.
//

import SwiftUI
struct MangeDescription: View {
    var body: some View {
        VStack(alignment:.leading) {
            
            HStack {
                Image(systemName: "square.fill")
                    .foregroundColor(Color("Chicago Maroon"))
                Text("Mange")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Link(destination: URL(string: "https://en.wikipedia.org/wiki/Mange")!) {
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                        .imageScale(.small)
                }

            }
            .padding(.bottom)
                        
            
            Text(mangeDescription)
                .multilineTextAlignment(.leading)
        }
        .padding(.leading)
    }
    
    
    
}

struct MangeDescription_Previews: PreviewProvider {
    static var previews: some View {
        MangeDescription()
    }
}
