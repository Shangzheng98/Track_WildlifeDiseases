//
//  Project Leader.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI
let contents = ["D.V.M., Universidad de San Carlos, Guatemala City, Guatemala (Avian Flu in Wild Birds) (2009)\n", "M.Sc., Wildlife Management, Universidad de San Carlos, Guatemala City, Guatemala (Community Ecology of Fleas in Guatemala) (2011)","M.Sc., Veterinary Sciences, Universidad Andres Bello, College of Ecology and Natural Resources, Chile (2012)","Ph.D., Conservation Medicine (Summa Cum Laude), Universidad Andres Bello, College of Ecology and Natural Resources, Chile (Ecology and Biogeography of Bat-borne Rabies) (2014)"]


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
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading) {
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
            .font(.body)
            .multilineTextAlignment(.leading)
            
            
                
        }
        .padding(.leading)
        .frame(maxHeight: 400.0)
        
    }
}

struct ProjectLeader_Previews: PreviewProvider {
    static var previews: some View {
        ProjectLeader()
    }
}
