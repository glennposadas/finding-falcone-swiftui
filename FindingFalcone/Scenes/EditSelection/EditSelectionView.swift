import SwiftUI

struct EditSelectionView: View {
  
  @ObservedObject var viewModel: EditSelectionViewModel {
    didSet {
      switch viewModel.selection.selectingFor {
      case .planet:
        selectedItemName = viewModel.selection.selection.planet?.name
      case .vehicle:
        selectedItemName = viewModel.selection.selection.vehicle?.name
      }
    }
  }
  
  /// The selected planet or vehicle, using its name.
  @State var selectedItemName: String?
  
  var body: some View {
    ZStack(alignment: .top) {
      GeometryReader { geometry in
        Color(.clear)
        List {
          Section(header: Text(viewModel.selectionSubtitle)) {
            switch viewModel.selection.selectingFor {
            case .planet:
              ForEach(Array(destinationManager.allPlanets), id: \.self) { item in
                let name = item.name
                SelectableWrapperCell(selected: self.$selectedItemName,
                                      wrapped: SelectionCell(item: name))
              }
            case .vehicle: Text("v")
            }
          }
        }
      }
      .navigationTitle(viewModel.selectionTitle)
    }
  }
}

//
//switch viewModel.selection.selectingFor {
//case .planet:
//
//case .vehicle:
//  ForEach(destinationManager.allVehicles, id: \.self) { item in
//    SelectableWrapperCell(selected: self.$selectedItemName,
//                          wrapped: SelectionCell(item: item))
//  }
//}
