//
//  AboutUs.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI

struct AboutUs: View {
    @EnvironmentObject var userData: UserData
    init() {
        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "backward.fill")!, transitionMaskImage: UIImage(systemName: "backward")!)
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color("Burnt Orange"))
        ]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color("Burnt Orange"))
        ]
        
//        navBarAppearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Description()
                        .padding(.bottom)
                    ProjectLeader()
                        .padding([.bottom, .top])
                    
                
                    MangeDescription()
                        
                    
                    
                }
                .navigationTitle(Text("About Us"))
            }
        }
        .onAppear{
            getNetWorkStatus()
            userData.networkStatus = netWorkStatus
            }
        
    
    }
    
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
        
    }
}
