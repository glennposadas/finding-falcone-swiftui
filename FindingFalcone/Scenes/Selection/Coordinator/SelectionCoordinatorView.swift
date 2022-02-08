import SwiftUI

struct SelectionCoordinatorView: View {
  
  // MARK: Stored Properties
  
  @ObservedObject var coordinator: SelectionCoordinator
  
  // MARK: Views
  
  var body: some View {
    NavigationView {
      SelectionView(viewModel: coordinator.viewModel)
        .navigation(item: $coordinator.editSelectionViewModel) { viewModel in
          EditSelectionView()
        }
        .alert("Error",
               isPresented: $coordinator.viewModel.hasError,
               presenting: coordinator.viewModel.state) { state in
          Button("Retry") {
            Task {
              await coordinator.viewModel.checkAndGetToken()
            }
          }
        } message: { state in
          if case let .failure(errorMessage) = state {
            Text(errorMessage)
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
}
