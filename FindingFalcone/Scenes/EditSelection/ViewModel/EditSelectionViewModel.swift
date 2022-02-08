import SwiftUI

class EditSelectionViewModel {
  
  // MARK: - Properties
  
  @Published var selection: DestinationManager.Selection

  private unowned let coordinator: SelectionCoordinator

  
  // MARK: - Functions
  // MARK: - Initialization
  
  init(selection: DestinationManager.Selection, coordinator: SelectionCoordinator) {
    self.selection = selection
    self.coordinator = coordinator
  }
  
  // MARK: - Public
  
}
