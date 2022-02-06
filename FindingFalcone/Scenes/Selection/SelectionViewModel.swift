import Foundation
import SwiftUI

class SelectionViewModel: ObservableObject {
  
  func checkAndGetToken() async {
    guard API.token.isEmpty else {
      return
    }
    
    let result = await API.shared.getToken()
    
    if case .success(let dictionary) = result,
       let token = dictionary["token"] as? String {
      print("Token: \(token)")
    } else if case .failure(let error) = result {
      print("Error SelectionViewModel: \(error.localizedDescription)")
    }
  }
}
