import SwiftUI

struct SelectableWrapperCell<Wrapped: View & ViewProtocol>: View {
  @Binding var selected: Wrapped.Model?
  var wrapped: Wrapped
  var body: some View {
    return HStack {
      wrapped
      Spacer()
      if selected == wrapped.item {
        Image(systemName: "checkmark")
      }
    }
    .contentShape(Rectangle())  // Important for [max] area to tap
    .onTapGesture {
      self.selected = self.wrapped.item
    }
  }
}
