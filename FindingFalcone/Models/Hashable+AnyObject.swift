import Foundation

extension Hashable where Self: AnyObject {
  func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }
}
