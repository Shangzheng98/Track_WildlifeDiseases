//
//  Project Leader.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI



struct ProjectLeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            Link(destination:URL(string:profileURL)!) {
                Text("Profile")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
            }
            
            HStack() {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text("Luis E. Escobar")
                        .font(.title2)
                    Text("Asst Professor AY")
                        .font(.title3)
                    
                    HStack {
                        Image(systemName: "envelope")
                        Text(email)
                    }
                        
                }
                .padding(.trailing)
            }
            Divider()
            Group {
                Text(contents[0])
                Divider()
                Text(contents[1])
                Divider()
                Text(contents[2])
                Divider()
                Text(contents[3])
            }
            .font(.system(size: 15))
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .multilineTextAlignment(.leading)
            
            
                
        }
        .padding([.leading,.bottom])
        
        
    }
}

struct ProjectLeader_Previews: PreviewProvider {
    static var previews: some View {
        ProjectLeader()
    }
}
