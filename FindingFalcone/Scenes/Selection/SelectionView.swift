import SwiftUI

struct SelectionView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel: SelectionViewModel
  
  // MARK: - Body
  
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      .onAppear {
        Task.init {
          await viewModel.checkAndGetToken()
          await viewModel.getPlanets()
        }
      }
  }
}

//struct SelectionView_Previews: PreviewProvider {
//  static var previews: some View {
//    SelectionView(viewModel: .init())
//  }
//}
