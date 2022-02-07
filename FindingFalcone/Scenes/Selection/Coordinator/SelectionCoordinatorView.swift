import SwiftUI

struct SelectionCoordinatorView: View {
  
  // MARK: Stored Properties
  
  @ObservedObject var coordinator: SelectionCoordinator
  
  // MARK: Views
  
  var body: some View {
    NavigationView {
      
      SelectionView(viewModel: coordinator.viewModel)
        .navigation(item: $coordinator.detailViewModel) { viewModel in
          if UIDevice.current.userInterfaceIdiom == .phone {
            phoneRecipeView(viewModel)
          } else {
            padRecipeView(viewModel)
          }
        }
    }
  }
