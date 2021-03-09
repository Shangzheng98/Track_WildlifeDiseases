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
            HStack {
                Image(systemName: "square.fill")
                    .foregroundColor(Color("Chicago Maroon"))
                Text("Profile")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    
            }.padding(.bottom)
            
            
            
            HStack() {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text("Luis E. Escobar")
                        .font(.system(size: 26))
                    Text("Asst Professor AY")
                        .font(.system(size: 22))
                        .padding(.top)
                    HStack {
                        Image(systemName: "envelope")
                        Text(email)
                    }
                    .padding(.top)
                    
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.medium)
                            .foregroundColor(.blue)
                        Link(destination: URL(string: profileURL)!) {
                            Text("More Details")
                                .foregroundColor(.blue)
                                
                        }
                        
                    }
                    .padding(.top)
                    
                        
                }
                .padding(.trailing)
                
            }
            Divider()
//            Group {
//
//                Divider()
//                Text(contents[1])
//                Divider()
//                Text(contents[2])
//                Divider()
//                Text(contents[3])
//            }
            
            
            Group {
                ForEach(contents,id: \.self) {
                    item in
                    Text(item)
                    Divider()
                    
                }
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
