import Foundation

typealias Planet = PlanetResponse

class PlanetResponse: BaseModel, Decodable {
  
  // MARK: - Properties
  
  var id: UUID
  var name: String
  var distance: Int
  
  // MARK: - Decodable
  
  enum CodingKeys: String, CodingKey {
    case name, distance
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    distance = try values.decodeIfPresent(Int.self, forKey: .distance) ?? 0
    id = UUID()
  }
  
  // MARK: - Static
  // MARK: Equatable
  
  static func == (lhs: PlanetResponse, rhs: PlanetResponse) -> Bool {
    lhs.id == rhs.id
  }
}
