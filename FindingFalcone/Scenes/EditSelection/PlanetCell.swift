import SwiftUI

/**
 Selection cell for planet types.
 */
struct PlanetCell: View, ViewProtocol {
  var selectionId: Int
  var item: Planet
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(item.name).fontWeight(.medium).scaledToFill()
      Text("\(item.distance) megamiles").italic().scaledToFill()
    }
  }
}
