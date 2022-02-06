import Foundation

class API: NSObject {
  static let shared = API()
  
  static let baseURLPath = "https://findfalcone.herokuapp.com/"
  
  static var token = Auth.shared.getTokenFromKeychain()
  
  private static var throttledURLSession: URLSession?
  
  internal func sharedThrottledURLSession() -> URLSession {
    if API.throttledURLSession == nil {
      let configuration = URLSession.shared.configuration
      configuration.httpMaximumConnectionsPerHost = 1
      API.throttledURLSession = URLSession(configuration: configuration)
    }
    
    return API.throttledURLSession!
  }
}
