import SwiftUI

struct SelectionCoordinatorView: View {
  
  // MARK: Stored Properties
  
  @ObservedObject var coordinator: SelectionCoordinator
  
  // MARK: Views
  
  var body: some View {
    SelectionView(viewModel: coordinator.viewModel)
      .navigation(item: $coordinator.editSelectionViewModel) { viewModel in
        EditSelectionView()
      }
  }
}
