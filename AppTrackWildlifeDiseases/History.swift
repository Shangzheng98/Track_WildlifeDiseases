//
//  History.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import SwiftUI
import MapKit
struct HistoryView: View {
    @Environment(\.managedObjectContext) var manageedObjectContext
    
    @FetchRequest(fetchRequest: Record.allRecordsFetchRequest())var allRecords: FetchedResults<Record>
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        NavigationView {
            Group {
                if !allRecords.isEmpty {
                    List {
                        ForEach(allRecords) {
                            record in
                            ListItem(record: record)
                        }
                    }
                    
                } else {
                    Text("You have not uploaded any records yet")
                }
            }
            .navigationTitle(Text("History"))
            
            
        }
        
    }
    
    
}

struct history_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
