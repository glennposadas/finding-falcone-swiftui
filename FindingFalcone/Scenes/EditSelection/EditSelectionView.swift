import SwiftUI

struct EditSelectionView: View {
  
  @ObservedObject var viewModel: EditSelectionViewModel {
    didSet {
      switch viewModel.selection.selectingFor {
      case .planet:
        selectedPlanet = viewModel.selection.selection.planet
      case .vehicle:
        selectedVehicle = viewModel.selection.selection.vehicle
      }
    }
  }
  
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
              ForEach(Array(destinationManager.allPlanets), id: \.id) { planet in
                SelectableWrapperCell(selected: self.$selectedPlanet,
                                      wrapped: PlanetCell(item: planet))
              }
            case .vehicle:
              ForEach(Array(destinationManager.allVehicles), id: \.id) { vehicle in
                SelectableWrapperCell(selected: self.$selectedVehicle,
                                      wrapped: VehicleCell(item: vehicle))
              }
            }
          }
        }
      }
      .navigationTitle(viewModel.selectionTitle)
    }
    .onDisappear {
      print("Edit selection view is closing... Commit changes... Planet: \(String(describing: selectedPlanet)) | Vehicle: \(String(describing: selectedVehicle))")
      viewModel.selection.selection.vehicle = selectedVehicle
      viewModel.selection.selection.planet = selectedPlanet
    }
  }
}
