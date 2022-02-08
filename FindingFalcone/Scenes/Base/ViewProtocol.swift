import Foundation

protocol ViewProtocol {
  associatedtype Model: Equatable
  var item: Model { get }
}
