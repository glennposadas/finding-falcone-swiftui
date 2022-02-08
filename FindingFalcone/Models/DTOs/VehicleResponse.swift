import Foundation

typealias Vehicle = VehicleResponse

class VehicleResponse: BaseModel, Decodable {
  var id: UUID
  var name: String
  var total, maxDistance, speed: Int
    
  enum CodingKeys: String, CodingKey {
    case name, speed
    case total = "total_no"
    case maxDistance = "max_distance"
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    total = try values.decodeIfPresent(Int.self, forKey: .total) ?? 0
    speed = try values.decodeIfPresent(Int.self, forKey: .speed) ?? 1
    maxDistance = try values.decodeIfPresent(Int.self, forKey: .maxDistance) ?? 0
    id = UUID()
  }
  
  static func == (lhs: VehicleResponse, rhs: VehicleResponse) -> Bool {
    lhs.id == rhs.id
  }
}
