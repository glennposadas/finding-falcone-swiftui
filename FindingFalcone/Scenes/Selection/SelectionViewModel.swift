import Foundation
import SwiftUI

@MainActor
final class SelectionViewModel: BaseViewModel {
  
  // MARK: - Properties

  @Published private(set) var planets = [Planet]()
  @Published private(set) var vehicles = [Vehicle]()
  
  @Published  var state: ViewModelState<[String]> = .loading
  @Published var hasError: Bool = false
  
  // MARK: - Functions
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
      handleError(error)
    }
  }
  
  @MainActor
  func getPlanets() async {
    let result = await API.shared.getPlanets()

    if case .success(let planets) = result {
      self.planets = planets
      self.state = .success(self.planets.map { $0.name })
    } else if case .failure(let error ) = result {
      handleError(error)
    }
  }

  @MainActor
  func getVehicles() async {
    let result = await API.shared.getVehicles()

    if case .success(let vehicles) = result {
      self.vehicles = vehicles
    } else if case .failure(let error ) = result {
      handleError(error)
    }
  }
  
  // MARK: - Private
  
  private func handleToken(_ token: String) {
    KeychainHelper.standard.save(token.data(using: .utf8),
                                 service: .apiToken,
                                 account: .api)
  }
  
  private func handleError(_ error: Error, function: String = #function) {
    self.state = .failure(error.localizedDescription)
    self.hasError = true
    print("Error SelectionViewModel \(function): \(error.localizedDescription)")
  }
 }
