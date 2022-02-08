import Foundation

extension API {
  /**
   Make a request to the server for the api token.
   
   - Returns: a dictionary with `token` as key.
   */
  func getToken() async -> Result<TokenResponse, Error> {
    let urlPath = API.baseURLPath + "token"
    var request = createRequest(urlPath: urlPath)
    request.httpMethod = "POST"
    
    return await withCheckedContinuation { continuation in
      processRequest(request,
                     debugName: "get token",
                     throttleConnections: true) { (result: Result<TokenResponse, Error>) in
        continuation.resume(returning: result)
      }
    }
  }
  
  /**
   Request for `planets`.
   
   - Returns: Array of Dictionary.
   */
  func getPlanets() async -> Result<[PlanetResponse], Error> {
    let urlPath = API.baseURLPath + "planets"
    var request = createRequest(urlPath: urlPath)
    request.httpMethod = "GET"
    
    return await withCheckedContinuation { continuation in
      processRequest(request,
                     debugName: "get planets",
                     throttleConnections: true) { (result: Result<[PlanetResponse], Error>) in
        continuation.resume(returning: result)
      }
    }
  }
  
  /**
   Request for `vehicles`.
   
   - Returns: Array of Dictionary.
   */
  func getVehicles() async -> Result<[VehicleResponse], Error> {
    let urlPath = API.baseURLPath + "vehicles"
    var request = createRequest(urlPath: urlPath)
    request.httpMethod = "GET"
    
    return await withCheckedContinuation { continuation in
      processRequest(request,
                     debugName: "get vehicles",
                     throttleConnections: true) { (result: Result<[VehicleResponse], Error>) in
        continuation.resume(returning: result)
      }
    }
  }
  
  /**
   Request for `find` - finding falcone.
   */
  func findFalcone(selections: [DestinationManager.Selection], token: String) async -> Result<FindFalconeResponse, Error> {
    let urlPath = API.baseURLPath + "find"
    var request = createRequest(urlPath: urlPath)
    request.httpMethod = "POST"
    
 
    
    let planetNames = selections.compactMap {
      $0.selection.planet?.name
    }
    
    let vehicleNames = selections.compactMap {
      $0.selection.vehicle?.name
    }
    
    let token = Auth.shared.getTokenFromKeychain()
    
    let jsonBody = [
      "token" : token,
      "planet_names" : planetNames,
      "vehicle_names" : vehicleNames
    ] as [String : Any]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
    
    print("httpBody:")
    print(jsonBody)

    return await withCheckedContinuation { continuation in
      processRequest(request,
                     debugName: "find falcone!",
                     throttleConnections: true) { (result: Result<FindFalconeResponse, Error>) in
        continuation.resume(returning: result)
      }
    }
  }
}
