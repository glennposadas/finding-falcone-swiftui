import SwiftUI

struct SelectionCell: View, ViewProtocol {
  var item: UUID
  
  var body: some View {
    VStack(alignment: .leading) {
      let name = destinationManager.getItemName(byUUID: item) ?? "Unknown"
      Text("name").fontWeight(.medium).scaledToFill()
    }
  }
}
