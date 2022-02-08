import SwiftUI

struct SelectionCoordinatorView: View {
  
  // MARK: Stored Properties
  
  @ObservedObject var coordinator: SelectionCoordinator
  
  // MARK: Views
  
  var body: some View {
    NavigationView {
      SelectionView(viewModel: coordinator.viewModel)
        .navigation(item: $coordinator.editSelectionViewModel) { viewModel in
          EditSelectionView(
            viewModel: .init(
              selection: viewModel.selection,
              coordinator: coordinator
            )
          )
        }
    }
    .task {
      await coordinator.viewModel.checkAndGetToken()
      await coordinator.viewModel.getPlanets()
      await coordinator.viewModel.getVehicles()
    }
    .refreshable {
      await coordinator.viewModel.refresh()
    }
  }
}
