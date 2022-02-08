import SwiftUI

class EditSelectionViewModel: BaseViewModel {
  
  // MARK: - Properties
  
  @Published var selection: DestinationManager.Selection

  @Published var selectionTitle: String = ""
  @Published var selectionSubtitle: String = ""
  
  var allPlanets: [Planet] {
    Array(destinationManager.allPlanets)
  }
  
  var allVehicles: [Vehicle] {
    Array(destinationManager.allVehicles)
  }
  
  private unowned let coordinator: SelectionCoordinator
  
  // MARK: - Functions
  // MARK: - Initialization
  
  init(selection: DestinationManager.Selection, coordinator: SelectionCoordinator) {
    self.selection = selection
    self.coordinator = coordinator
    super.init()
    
    setup()
    print("\(self): \(selection)")
  }
  
  // MARK: - Private
  
  private func setup() {
    selectionTitle = "Destination \(selection.id + 1)"
    selectionSubtitle = "Select a \(selection.selectingFor)"
  }
  
  // MARK: - Public
  
  func askForValidation() {
    coordinator.viewModel.validateInputs()
  }
  
  func commit(selectedPlanet: Planet?) {
    guard let selectedPlanet = selectedPlanet else {
      return
    }
    selection.selection.planet = selectedPlanet
  }
  
  func commit(selectedVehicle: Vehicle?) {
    guard let selectedVehicle = selectedVehicle else {
      return
    }
    selection.selection.vehicle = selectedVehicle
  }
}
