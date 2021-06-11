import Foundation


enum HTTPTask{
    case resquestQuery
    case resquest
    case requestParameters(parameters : ObjectOutput)
}


public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
