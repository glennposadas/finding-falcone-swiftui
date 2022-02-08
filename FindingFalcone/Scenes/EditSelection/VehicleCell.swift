import SwiftUI

/**
 Selection cell for vehicle types.
 */
struct VehicleCell: View, ViewProtocol {
  var selectionId: Int
  var item: Vehicle
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(item.name).fontWeight(.medium).scaledToFill()
      Text("Max Distance: \(item.maxDistance) megamiles").italic().scaledToFill()
      Text("\(item.speed) megamiles/hour").italic().scaledToFill()
    }
  }
}

