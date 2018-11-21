import Foundation

// MARK: - Map

func toString(scope: AccessScope) -> String {
    return scope.rawValue
}

func toArrayOfParameters<A>(withName name: String) -> (A) -> Parameter {
    return { value in Parameter(name: "\(name)[]", value: String(describing: value)) }
}

func between(_ min: Int, and max: Int, fallback: Int) -> (Int) -> Int {
    return { limit in (limit >= min && limit <= max) ? limit : fallback }
}

// MARK: - Flat-map

func asString(json: JSONObject) -> String? {
    return json as? String
}

func asJSONDictionary(json: JSONObject) -> JSONDictionary? {
    return json as? JSONDictionary
}

func asJSONDictionaries(json: JSONObject) -> [JSONDictionary]? {
    return json as? [JSONDictionary]
}

func toOptionalString<A>(optional: A?) -> String? {
    return optional.flatMap { String(describing: $0) }
}

func toQueryItem(parameter: Parameter) -> URLQueryItem? {
    guard let value = parameter.value as? String else { return nil }
    return URLQueryItem(name: parameter.name, value: value)
}

func toString(parameter: Parameter) -> String? {
    if let value = parameter.value as? String {
        return value.addingPercentEncoding(withAllowedCharacters: .bodyAllowed).flatMap { value in "\(parameter.name)=\(value)" }
    } else if let value = parameter.value as? [String] {
        return value.reduce("") { result, value in
            return "\(result ?? "")&\(parameter.name)[]=\(value)"
        }
    } else if let value = parameter.value as? Bool {
        return "\(parameter.name)=\(value)"
    }
        
    return nil
}

func trueOrNil(_ flag: Bool) -> String? {
    return flag ? "true" : nil
}
