import Foundation

class FindFalconeResponse: Decodable {
  
  // MARK: - Properties
  
  var status: String
  var planetName: String?
  
  // MARK: - Decodable
  
  enum CodingKeys: String, CodingKey {
    case status
    case planetName = "planet_name"
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
    planetName = try values.decodeIfPresent(String.self, forKey: .planetName)
  }
}

// MARK: - CustomStringConvertible

extension FindFalconeResponse: CustomStringConvertible {
  var description: String {
    "Find falcone response: status: \(status) | planet name found?: \(planetName ?? "none")"
  }
}
