import Foundation

typealias Planet = PlanetResponse

class PlanetResponse: Decodable,
                      Identifiable,
                      Equatable,
                      Hashable {
  
  var name: String
  var distance: Int
  
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
  
  static func == (lhs: PlanetResponse, rhs: PlanetResponse) -> Bool {
    lhs.id == rhs.id
  }
}
