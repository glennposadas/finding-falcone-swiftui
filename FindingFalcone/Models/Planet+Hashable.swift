import Foundation

typealias Planet = PlanetResponse

extension Planet: Hashable {
  static func == (lhs: PlanetResponse, rhs: PlanetResponse) -> Bool {
    lhs.name == rhs.name
  }
}
