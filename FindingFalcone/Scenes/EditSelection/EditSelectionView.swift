import SwiftUI

struct EditSelectionView: View {
  
  @ObservedObject var viewModel: EditSelectionViewModel
  
  var body: some View {
    ZStack(alignment: .top) {
      GeometryReader { geometry in
        Color(.clear)
        VStack(alignment: .leading) {
          HStack {
            Text(viewModel.selectionSubtitle)
              .multilineTextAlignment(.leading)
              .padding(.leading, 22)
          }
          
          let withIndex = destinationManager.selections.enumerated().map({ $0 })
          
          List(withIndex, id: \.element.id) { index, selection in
            Section(header: Text("Destination \(index + 1)")) {
              Text(selection.planetNamePresentable)
                .font(.headline)
                .onNavigation {

                }
              
              Text(selection.vehicleNamePresentable)
                .font(.headline)
                .onNavigation {
                  
                }
            }.headerProminence(.increased)
          }
        }
      }
    }
    .navigationTitle(viewModel.selectionTitle)
  }
}

struct MyPreviewProvider_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EditSelectionView(viewModel: .init(selection: DestinationManager.Selection(id: 0), coordinator: SelectionCoordinator()))
    }
  }
}
