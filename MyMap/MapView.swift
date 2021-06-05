import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let searchKey: String
    let mapType: MKMapType
    let coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("searchKey: ", searchKey)
        
        uiView.mapType = mapType
        
        if searchKey != "" {
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(
                searchKey,
                completionHandler: { (placemarks,  error) in
                    if let unwrapPlacemarks = placemarks,
                       let firstPlacemark = unwrapPlacemarks.first,
                       let location = firstPlacemark.location{
                        let targetCoordinate = location.coordinate
                        print("targetCoordinate: ", targetCoordinate)
                        
                        let pin = MKPointAnnotation()
                        pin.coordinate = targetCoordinate
                        pin.title = searchKey
                        uiView.addAnnotation(pin)
                        uiView.region = MKCoordinateRegion(
                            center: targetCoordinate,
                            latitudinalMeters: 500.0,
                            longitudinalMeters: 500.0
                        )
                    }
                }
            )
        } else if CLLocationCoordinate2DIsValid(coordinate) {
            
            print("coordinate: ", coordinate)
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title = String (coordinate.latitude) + "," + String (coordinate.longitude)
            uiView.addAnnotation(pin)
            uiView.region = MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 500.0,
                longitudinalMeters: 500.0
            )
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "", mapType: .standard, coordinate: CLLocationCoordinate2DMake(0.0, 0.0))
    }
}
