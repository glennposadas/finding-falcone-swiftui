import Foundation

class Auth {
  static let shared = Auth()
  
  /**
   Extracts the stored token in the Keychain.
   */
  func getTokenFromKeychain() -> String {
    if let data = KeychainHelper.standard.read(service: .apiToken, account: .api),
       let t = String(data: data, encoding: .utf8) {
      return t
    }
    
    return ""
  }
  
  /**
   Store a new token in the Keychain
   */
  func storeTokenToKeychain(_ token: String) {
    guard let data = token.data(using: .utf8) else {
      return
    }
    
    KeychainHelper.standard.save(data, service: .apiToken, account: .api)
  }
}
#imageLiteral(resourceName: "simulator_screenshot_7E804100-8D25-4DE3-8C2C-D47E8D934286.png")
