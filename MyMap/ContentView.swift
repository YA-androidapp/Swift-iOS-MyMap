import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var manager = LocationManager()
    
    @State var inputCoordinate:String = ""
    @State var inputSearchKey:String = ""
    @State var dispCoordinate = CLLocationCoordinate2DMake(0.0, 0.0)
    @State var dispSearchKey:String = ""
    @State var dispMapType:MKMapType = .standard
    
    var body: some View {
        VStack {
            HStack{
                let latetude = $manager.location.wrappedValue.coordinate.latitude
                let longitude = $manager.location.wrappedValue.coordinate.longitude
                Text(String(latetude) + "," + String(longitude)).padding()
                Spacer()
                Button(
                    action: {
                        dispCoordinate = CLLocationCoordinate2DMake(latetude, longitude)
                    }
                ) {
                    Image(systemName: "mappin").frame(
                        width: 35.0, height: 35.0, alignment: .leading)
                }
            }
            TextField(
                "Input a keyword.",
                text: $inputSearchKey, onCommit: {
                    dispSearchKey = inputSearchKey
                }
            ).padding()
            
            ZStack(alignment: .bottomTrailing){
                MapView(searchKey: dispSearchKey, mapType: dispMapType, coordinate: dispCoordinate)
                
                Button(
                    action: {
                        if dispMapType == .standard {
                            dispMapType = .satellite
                        } else if dispMapType == .satellite {
                            dispMapType = .standard
                        }
                    }
                ) {
                    Image(systemName: "map").resizable().frame(
                        width: 35.0, height: 35.0, alignment: .leading)
                }.padding(.trailing, 20.0).padding(.bottom, 30.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
