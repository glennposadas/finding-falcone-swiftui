import Foundation

protocol BaseModel: AnyObject, Equatable & Hashable {
  var id: UUID { get set }
  var name: String { get set }
}
