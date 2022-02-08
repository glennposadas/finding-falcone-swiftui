import SwiftUI

struct SelectableWrapperCell<Wrapped: View & ViewProtocol>: View {
  @Binding var selected: Wrapped.Model?
  var wrapped: Wrapped
  
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
        selected = wrapped.item
      }
    }
  }
}
