import Foundation

typealias Vehicle = VehicleResponse

class VehicleResponse: BaseModel, Decodable {
  
  // MARK: - Properties
  
  var id: UUID
  var name: String
  var total, maxDistance, speed: Int
  
  // MARK: - Decodable
  
  enum CodingKeys: String, CodingKey {
    case name, speed
    case total = "total_no"
    case maxDistance = "max_distance"
  }
  
  init(id: UUID, name: String, total: Int, maxDistance: Int, speed: Int) {
    self.id = id
    self.name = name
    self.total = total
    self.maxDistance = maxDistance
    self.speed = speed
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    total = try values.decodeIfPresent(Int.self, forKey: .total) ?? 0
    speed = try values.decodeIfPresent(Int.self, forKey: .speed) ?? 1
    maxDistance = try values.decodeIfPresent(Int.self, forKey: .maxDistance) ?? 0
    id = UUID()
  }
  
  // MARK: - Public
  
  /// Make a new copy of vehicle, but with different id.
  func newCopy() -> VehicleResponse {
    let newVehicle = VehicleResponse(
      id: UUID(),
      name: name,
      total: total,
      maxDistance: maxDistance,
      speed: speed
    )
    return newVehicle
  }
  
  // MARK: - Static
  // MARK: Equatable
  
  static func == (lhs: VehicleResponse, rhs: VehicleResponse) -> Bool {
    lhs.id == rhs.id
  }
}

// MARK: - CustomStringConvertible

extension Vehicle: CustomStringConvertible {
  var description: String {
    "Planet id: \(id) | name: \(name) | speed: \(speed) | maxDistance: \(maxDistance)"
  }
}
