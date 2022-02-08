import SwiftUI

class SelectionCoordinator: ObservableObject, Identifiable {
  
  // MARK: - Properties
  
  @Published var viewModel: SelectionViewModel!
  @Published var editSelectionViewModel: EditSelectionViewModel?
  
  // MARK: - Functions
  // MARK: - Initialization
  
  init() {
    self.viewModel = .init(coordinator: self)
  }
  
  // MARK: - Public
  
  func openForPlanet(_ selection: DestinationManager.Selection) {
    editSelectionViewModel = .init(selection: selection, coordinator: self)
  }

  func openForVehicle(_ selection: DestinationManager.Selection) {
    editSelectionViewModel = .init(selection: selection, coordinator: self)
  }
}
