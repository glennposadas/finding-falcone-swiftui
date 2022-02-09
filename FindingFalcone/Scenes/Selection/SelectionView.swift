import SwiftUI

struct SelectionView: View {
  
  // MARK: - Properties
  
  @ObservedObject var viewModel: SelectionViewModel
  
  // MARK: - Body
  
  var body: some View {
    ZStack {
      switch viewModel.state {
      case .success(let selections):
        let withIndex = selections.enumerated().map({ $0 })
        
        VStack {
          List(withIndex, id: \.element.id) { index, selection in
            Section(header: Text("Destination \(index + 1)")) {
              Text(selection.planetNamePresentable)
                .font(.headline)
                .onNavigation {
                  selection.selectingFor = .planet
                  viewModel.selectPlanet(forSelection: selection)
                }
              
              Text(selection.vehicleNamePresentable)
                .font(.headline)
                .onNavigation {
                  selection.selectingFor = .vehicle
                  viewModel.selectVehicle(forSelection: selection)
                }
            }.headerProminence(.increased)
          }
          .toolbar {
            Button("Find Falcone!") {
              print("Let's go!")
              Task {
                await viewModel.findFalcone()
              }
            }.disabled(!viewModel.findFalconeButtonIsEnabled)
          }
          .listStyle(.insetGrouped)
          .navigationBarTitle("Select Destinations")
          Text("Time taken: \(viewModel.timeTaken)")
          Spacer()
        }
        
      case .loading:
        ZStack(alignment: .center) {
          Color(.clear)
          VStack(alignment: .center, spacing: 8) {
            ProgressView()
            Text("Loading")
          }
        }.ignoresSafeArea()
      default:
        EmptyView()
      }
    }
    
    .alert("Error",
           isPresented: $viewModel.hasError,
           presenting: viewModel.state) { state in
      Button("Retry") {
        Task {
          await viewModel.refresh()
        }
      }
    } message: { state in
      if case let .failure(errorMessage) = state {
        Text(errorMessage)
      }
    }
    
    .alert(viewModel.findFalconeMessage,
           isPresented: $viewModel.hasSucceededCallingFindFalcone,
           presenting: "") { message in
      Button("Start Again") {
        Task {
          await viewModel.gameOver()
        }
      }
      Button("Cancel") {
        
      }
    } message: { message in
      Text(message)
      Text("Time taken: \(viewModel.timeTaken)")
    }
    
    .alert("Please wait...",
           isPresented: $viewModel.hasCalledFindFalcone,
           presenting: viewModel.findFalconeMessage) { message in
    } message: { message in
      ProgressView()
    }
  }
}
