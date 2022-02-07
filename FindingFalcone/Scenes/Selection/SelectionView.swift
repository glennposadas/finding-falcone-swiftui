import SwiftUI

struct SelectionView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel: SelectionViewModel
  
  // MARK: - Body
  
  var body: some View {
    NavigationView {
      switch viewModel.state {
      case .success(let data):
        List {
          ForEach(data, id: \.self) { item in
            Text(item)
          }
        }
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
      await viewModel.checkAndGetToken()
      await viewModel.getPlanets()
      await viewModel.getVehicles()
    }
  }
}

struct SelectionView_Previews: PreviewProvider {
  static var previews: some View {
    SelectionView(viewModel: .init())
  }
}

