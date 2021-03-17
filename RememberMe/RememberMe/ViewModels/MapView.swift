//
//  MapView.swift
//  RememberMe
//
//  Created by Anthony You on 17/03/2021.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
    
    var annotation: MKPointAnnotation?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        if let annotation = annotation {
            let span = MKCoordinateSpan.init(latitudeDelta: 5, longitudeDelta: 5)
            let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if let annotation = annotation {
            view.addAnnotation(annotation)
        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotation: MKPointAnnotation.example)
    }
}
