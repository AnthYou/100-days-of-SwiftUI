//
//  MapViewIntroduction.swift
//  BucketList
//
//  Created by Anthony You on 13/03/2021.
//

import MapKit
import SwiftUI

struct MapViewIntroduction: UIViewRepresentable {
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewIntroduction

        init(_ parent: MapViewIntroduction) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
    }
}

struct MapViewIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        MapViewIntroduction()
    }
}
