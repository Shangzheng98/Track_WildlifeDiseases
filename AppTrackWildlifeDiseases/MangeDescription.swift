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
            Link(destination: URL(string: "https://en.wikipedia.org/wiki/Mange")!) {
                Text("Mange")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
            }
            
            
            Text(mangeDescription)
                .multilineTextAlignment(.leading)
        }
    }
    
    
    
}

struct MangeDescription_Previews: PreviewProvider {
    static var previews: some View {
        MangeDescription()
    }
}
