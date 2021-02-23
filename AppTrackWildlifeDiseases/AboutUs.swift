//
//  AboutUs.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI

struct AboutUs: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Description()
                        .padding(.bottom)
                    ProjectLeader()
                        .padding([.bottom, .top])
                    
                    if userData.networkStatus != "offline" {
                        MangeDescription()
                        }
                    }
                
            }
            .navigationBarTitle(Text("About Us"))
    
            
        }
        
    }
    
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
