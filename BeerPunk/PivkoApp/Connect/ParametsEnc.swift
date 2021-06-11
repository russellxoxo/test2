import Foundation

struct ObjectOutput : Codable {
}

public enum ParametersEncoding{
    case jsonEncoding
}

public typealias Parameters = [String : Any]

public protocol ParameterEncoder{
    func encode( parameters : Parameters) throws
}



