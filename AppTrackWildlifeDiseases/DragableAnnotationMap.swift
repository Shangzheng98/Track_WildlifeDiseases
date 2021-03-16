//
//  DragableAnnotationMap.swift
//  TrackDiseases
//
//  Created by Shangzheng Ji on 3/16/21.
//  Copyright © 2021 Team1. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI

//https://www.youtube.com/watch?v=QuYA7gQjTt4
struct mapView: UIViewRepresentable {
    @Binding var latitude : Double
    @Binding var longtitude: Double
    var locationLat:Double
    var locationLong:Double
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        let coordinate = CLLocationCoordinate2D(latitude: locationLat , longitude: locationLong)
        map.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        map.delegate = context.coordinator
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> mapView.Coordinator {
        return mapView.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject,MKMapViewDelegate {
        var parent: mapView
        init(parent: mapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView,viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pin.isDraggable = true
            pin.pinTintColor = .red
            pin.animatesDrop = true
            self.parent.latitude = (pin.annotation?.coordinate.latitude)!
            self.parent.longtitude = (pin.annotation?.coordinate.longitude)!
            return pin
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            self.parent.latitude = (view.annotation?.coordinate.latitude)!
            self.parent.longtitude = (view.annotation?.coordinate.longitude)!
        }
    }
    
    
}
