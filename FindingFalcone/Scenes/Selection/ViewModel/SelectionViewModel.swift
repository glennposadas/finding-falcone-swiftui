import Foundation
import SwiftUI

final class SelectionViewModel: BaseViewModel {
  
  // MARK: - Properties

  /// Planet collection
  @Published private(set) var planets = [Planet]()
  /// Vehicle collection
  @Published private(set) var vehicles = [Vehicle]()
  
  /// Current state of the VM
  @Published var state: ViewModelState<[DestinationManager.Selection]> = .loading
  /// Do we have a current error?
  @Published var hasError: Bool = false
  
  /// Determines if the find falcone button is enabled or not
  @Published var findFalconeButtonIsEnabled = false
  
  /// The manager for selections
  private(set) var destinationManager = DestinationManager()
  
  /// The coordinator for this flow.
  private unowned let coordinator: SelectionCoordinator
  
  // MARK: - Functions
  // MARK: - Initialization
  
  init(coordinator: SelectionCoordinator) {
    self.coordinator = coordinator
  }
  
  // MARK: - Public
  
  /// A dedicated refresh function. 
  func refresh() async {
    await checkAndGetToken()
    await getPlanets()
    await getVehicles()
  }
  
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
      destinationManager.populateInitialSelections()
      state = .success( destinationManager.selections )
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
  
  // MARK: Navigations & Handlers
  
  func selectPlanet(forSelection selection: DestinationManager.Selection) {
    print("open selection for planet...")
    coordinator.openForPlanet(selection)
  }
  
  func selectVehicle(forSelection selection: DestinationManager.Selection) {
    print("open selection for vehicle...")
    coordinator.openForVehicle(selection)
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
