import Foundation

public protocol PhoneNumber {
    var contentFlags: Int16 { get }
    var isScam: Bool { get set }
    var label: String? { get }
    var phoneNumber: Int64 { get }
}

public enum ContentFlags: Int16 {
    case internalContent = 0b00000001
    case userGeneratedContent = 0b00000010
}
