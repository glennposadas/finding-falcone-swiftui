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
}
