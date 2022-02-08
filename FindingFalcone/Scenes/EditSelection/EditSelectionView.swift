import SwiftUI

struct EditSelectionView: View {
  
  @ObservedObject var viewModel: EditSelectionViewModel
  
  /// The selected planet.
  @State var selectedPlanet: Planet?
  /// The selected vehicle.
  @State var selectedVehicle: Vehicle?
  
  var body: some View {
    ZStack(alignment: .top) {
      GeometryReader { geometry in
        Color(.clear)
        List {
          Section(header: Text(viewModel.selectionSubtitle)) {
            switch viewModel.selection.selectingFor {
            case .planet:
              ForEach(viewModel.allPlanets, id: \.id) { planet in
                SelectableWrapperCell(selected: self.$selectedPlanet,
                                      wrapped: PlanetCell(selectionId: viewModel.selection.id, item: planet))
              }
            case .vehicle:
              ForEach(viewModel.allVehicles, id: \.id) { vehicle in
                SelectableWrapperCell(selected: self.$selectedVehicle,
                                      wrapped: VehicleCell(selectionId: viewModel.selection.id, item: vehicle))
              }
            }
          }
        }
      }
      .navigationTitle(viewModel.selectionTitle)
    }
    .onAppear {
      selectedPlanet = viewModel.selection.selection.planet
      selectedVehicle = viewModel.selection.selection.vehicle
    }
    .onDisappear {
      print("Edit selection view is closing... Commit changes... Planet: \(String(describing: selectedPlanet)) | Vehicle: \(String(describing: selectedVehicle))")
      viewModel.commit(selectedPlanet: selectedPlanet)
      viewModel.commit(selectedVehicle: selectedVehicle)
    }
  }
}
