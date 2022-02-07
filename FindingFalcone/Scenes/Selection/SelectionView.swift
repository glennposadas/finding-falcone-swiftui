import SwiftUI

struct SelectionView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel: SelectionViewModel
  
  // MARK: - Body
  
  var body: some View {
    NavigationView {
      switch viewModel.state {
      case .success(let selections):
        let withIndex = selections.enumerated().map({ $0 })
        
        List(withIndex, id: \.element.id) { index, selection in
          Section(header: Text("Destination \(index + 1)")) {
            Text(selection.planetNamePresentable)
                .font(.headline)
                .onNavigation { viewModel.selectPlanet(forSelection: selection) }
            
            Text(selection.vehicleNamePresentable)
                .font(.headline)
                .onNavigation { viewModel.selectVehicle(forSelection: selection) }
          }.headerProminence(.increased)
        }
        .listStyle(.insetGrouped)
        .navigationBarTitle("Finding Falcone")
        
      case .loading:
        VStack(spacing: 8) {
          ProgressView()
          Text("Loading")
        }
      default:
        EmptyView()
      }
    }
    .alert("Error",
           isPresented: $viewModel.hasError,
           presenting: viewModel.state) { detail in
      Button("Retry") {
        Task {
          await viewModel.checkAndGetToken()
        }
      }
    } message: { detail in
      if case let .failure(errorMessage) = detail {
        Text(errorMessage)
      }
    }
    .task {
      await viewModel.checkAndGetToken()
      await viewModel.getPlanets()
      await viewModel.getVehicles()
    }
    .refreshable {
      await viewModel.refresh()
    }
  }
}
