import Foundation

final class KeychainHelper {
  
  static let standard = KeychainHelper()
  
  enum ServiceType: String {
    case apiToken
  }
  
  enum AccountType: String {
    case api
  }
  
  private init() {}
  
  func save(_ data: Data, service: ServiceType, account: AccountType) {
    let query = [
      kSecValueData: data,
      kSecAttrService: service.rawValue,
      kSecAttrAccount: account.rawValue,
      kSecClass: kSecClassGenericPassword
    ] as CFDictionary
    // Add data in query to keychain
    let status = SecItemAdd(query, nil)
    if status == errSecDuplicateItem {
      // Item already exist, thus update it.
      let query = [
        kSecAttrService: service.rawValue,
        kSecAttrAccount: account.rawValue,
        kSecClass: kSecClassGenericPassword,
      ] as CFDictionary
      let attributesToUpdate = [kSecValueData: data] as CFDictionary
      // Update existing item
      SecItemUpdate(query, attributesToUpdate)
    }
  }
  
  func read(service: ServiceType, account: AccountType) -> Data? {
    let query = [
      kSecAttrService: service.rawValue,
      kSecAttrAccount: account.rawValue,
      kSecClass: kSecClassGenericPassword,
      kSecReturnData: true
    ] as CFDictionary
    var result: AnyObject?
    SecItemCopyMatching(query, &result)
    return (result as? Data)
  }
  
  func delete(service: ServiceType, account: AccountType) {
    let query = [
      kSecAttrService: service.rawValue,
      kSecAttrAccount: account.rawValue,
      kSecClass: kSecClassGenericPassword,
    ] as CFDictionary
    // Delete item from keychain
    SecItemDelete(query)
  }
}

extension KeychainHelper {
  func save<T>(_ item: T, service: ServiceType, account: AccountType) where T : Codable {
    do {
      // Encode as JSON data and save in keychain
      let data = try JSONEncoder().encode(item)
      save(data, service: service, account: account)
    } catch {
      assertionFailure("Fail to encode item for keychain: \(error)")
    }
  }
  func read<T>(service: ServiceType, account: AccountType, type: T.Type) -> T? where T : Codable {
    // Read item data from keychain
    guard let data = read(service: service, account: account) else {
      return nil
    }
    // Decode JSON data to object
    do {
      let item = try JSONDecoder().decode(type, from: data)
      return item
    } catch {
      assertionFailure("Fail to decode item for keychain: \(error)")
      return nil
    }
  }
}
