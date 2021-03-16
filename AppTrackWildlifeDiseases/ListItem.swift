//
//  ListItem.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import SwiftUI
import MapKit
struct ListItem: View {
    let record:Record
    @State private var location = ""
    var body: some View {
        HStack {
            getImageFromBinaryData(binaryData: record.photo!.photo ?? UIImage(named: "ImageUnavailable")?.jpegData(compressionQuality: 1.0) , defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar")
                        .imageScale(.medium)
                        .foregroundColor(Color("Chicago Maroon"))
                    
                    Text(record.date ?? "not aviliable")
                }
                HStack {
                    Image(systemName: "location.fill")
                        .imageScale(.medium)
                        .foregroundColor(.blue)
                    
                    Text("Lat: \(formatter(number: Double(truncating: record.latitude!))), Lon: \(formatter(number: Double(truncating: record.longitude!)))")
                    
                }
                .padding([.top, .bottom])
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .imageScale(.medium)
                        .foregroundColor(.red)
                    Text(location)
                }
                
            }
            
        }
        .font(.system(size: 18))
        .onAppear(perform: {
            
            getLocation()
        })
    }
    
    func formatter(number: Double) -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let n = Double(number)
        return formatter.string(from: NSNumber(value: n)) ?? "$0"
    }
    
    func getLocation() {
//        var r: String = ""
//        let sem = DispatchSemaphore(value: 0)
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: Double(truncating: record.latitude!), longitude: Double(truncating: record.longitude!))) {
            (place, error) in
            location = (place?.first?.name) ?? "" + " " + (place?.first?.locality ?? "")
            
        }
        
    }
}


