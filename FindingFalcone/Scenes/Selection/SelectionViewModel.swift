import Foundation
import SwiftUI

class SelectionViewModel: ObservableObject {
  
  // MARK: - Public
  
  func checkAndGetToken() async {
#if !DEBUG
    guard API.token.isEmpty else {
      return
    }
#endif
    
    let result = await API.shared.getToken()
    
    if case .success(let tokenResponse) = result {
      print("Token: \(tokenResponse)")
      handleToken(tokenResponse.token)
    } else if case .failure(let error) = result {
      print("Error SelectionViewModel: \(error.localizedDescription)")
    }
  }
  
  func getPlanets() async -> [PlanetResponse] {
    let result = await API.shared.getPlanets()

    if case .success(let planets) = result {
      return planets
    } else if case .failure(let error ) = result {
      print("Error SelectionViewModel: \(error.localizedDescription)")
    }
    
    return []
  }

  func getVehicles() async -> [VehicleResponse] {
    let result = await API.shared.getVehicles()

    if case .success(let vehicles) = result {
      return vehicles
    } else if case .failure(let error ) = result {
      print("Error SelectionViewModel: \(error.localizedDescription)")
    }
    
    return []
  }
  
  // MARK: - Private
  
  private func handleToken(_ token: String) {
    KeychainHelper.standard.save(token.data(using: .utf8),
                                 service: .apiToken,
                                 account: .api)
  }
}
