import Foundation

typealias Vehicle = VehicleResponse

extension Vehicle: Hashable {
  static func == (lhs: VehicleResponse, rhs: VehicleResponse) -> Bool {
    lhs.name == rhs.name
  }
}
