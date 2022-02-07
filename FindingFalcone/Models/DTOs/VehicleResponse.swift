import Foundation

struct VehicleResponse: Decodable {
  let name: String
  let total, maxDistance, speed: Int
  
  enum CodingKeys: String, CodingKey {
    case name, speed
    case total = "total_no"
    case maxDistance = "max_distance"
  }
}
