import SwiftUI

struct SelectableWrapperCell<Wrapped: View & ViewProtocol>: View {
  @Binding var selected: Wrapped.Model?
  var wrapped: Wrapped
  
  @State var hasSelectedInvalidDistance: Bool = false
  
  var body: some View {
    let isDisabled = wrapped.item.isSelectedOutsideSelection(selectionId: wrapped.selectionId)
    
    HStack {
      wrapped
      Spacer()
      if selected == wrapped.item {
        Image(systemName: "checkmark")
      }
    }
    .background {
      if isDisabled {
        Color.gray.opacity(0.5)
      }
    }
    .contentShape(Rectangle())  // Important for [max] area to tap
    .onTapGesture {
      if !isDisabled {
        if wrapped.item.maxDistanceVehicleIsMet(selectionId: wrapped.selectionId) {
          selected = wrapped.item
          hasSelectedInvalidDistance = false
        } else {
          hasSelectedInvalidDistance = true
        }
      }
    }
    .alert("Max distance of vehicle should be greater than or equal to the distance of the planet",
           isPresented: $hasSelectedInvalidDistance,
           presenting: hasSelectedInvalidDistance) { _ in
    }
  }
}
