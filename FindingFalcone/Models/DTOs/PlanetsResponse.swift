import Foundation

class PlanetResponse: Decodable, Identifiable, Equatable {
  let name: String
  let distance: Int
  
  private(set) var id: UUID
  
  enum CodingKeys: String, CodingKey {
    case name, distance
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    distance = try values.decodeIfPresent(Int.self, forKey: .distance) ?? 0
    id = UUID()
  }
}
