import Foundation

protocol ViewProtocol {
  associatedtype Model: BaseModel
  var item: Model { get }
}
