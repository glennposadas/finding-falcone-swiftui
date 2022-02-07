import Foundation

class BaseViewModel: ObservableObject {
  enum ViewModelState<T> {
    case initial
    case loading
    case failure(String)
    case success(T)
  }
  
  deinit {
    print("Deinit VM: \(self)")
  }
}
