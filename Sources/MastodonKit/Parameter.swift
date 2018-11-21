import Foundation

struct Parameter {
    let name: String
    let value: Any?
}

// MARK: - Equatable

extension Parameter : Equatable {
    static func == (lhs: Parameter, rhs: Parameter) -> Bool {
        return lhs.name == rhs.name// && lhs.value == rhs.value
    }
}
