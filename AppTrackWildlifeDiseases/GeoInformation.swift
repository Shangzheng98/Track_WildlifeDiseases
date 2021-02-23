//
//  GeoInformation.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import Foundation
import CoreLocation
 
/*
 Instantiate a CLLocationManager object globally. If you do this in the currentLocation()
 function below, requestWhenInUseAuthorization() message quickly disappears and the user is not
 given enough time to authorize location determination because exiting the called function
 terminates the locationManager. If it is global, it stays even after exiting the function.
 */
let locationManager = CLLocationManager()
 
/*
 ==================================================
 |   Get User's Permission for Current Location   |
 ==================================================
*/
public func getPermissionForLocation() {
    /*
     We need to obtain the user's permission to access his/her location much before we need it.
     Doing this in the currentLocation() function below would be too late since it will not be
     recorded in time to allow access when the function executes. Therefore, we call this
     function from AppDelegate upon app launch and do it here.
    */
    locationManager.requestWhenInUseAuthorization()
  
    // Another option: locationManager.requestAlwaysAuthorization()
}
 
/*
 ============================================================
 |   Obtain and Return User's Current Location Coordinate   |
 ============================================================
*/
public func currentLocation() -> CLLocationCoordinate2D {
    /*
     🔴 Current GPS location cannot be accurately determined under the iOS Simulator
        on your laptop or desktop computer because those computers do NOT have a GPS antenna.
        Therefore, do NOT expect the code herein to work under the iOS Simulator!
    
     You must deploy your location-aware app to an iOS device to be able to test it properly.
 
     Monitoring the user's current location is a serious privacy issue!
     🔴 Set one of the "Privacy - Location ..." keys in the Info.plist
        to display an alert message asking for user's permission.
     */
 
    // Instantiate a CLLocationCoordinate2D object with initial values
    var currentLocationCoordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
 
    /*
     The user can turn off location services on an iOS device in Settings.
     First, you must check to see of it is turned off or not.
     */
    if CLLocationManager.locationServicesEnabled() {
             
        // Set up locationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
     
        // Ask locationManager to obtain the user's current location coordinate
        if let location = locationManager.location {
            currentLocationCoordinate = location.coordinate
        } else {
            print("Unable to obtain user's current location")
        }
     
    } else {
        // Location Services turned off in Settings
    }
    // Stop updating location when not needed to save battery of the device
    locationManager.stopUpdatingLocation()
 
    return currentLocationCoordinate
}
 
