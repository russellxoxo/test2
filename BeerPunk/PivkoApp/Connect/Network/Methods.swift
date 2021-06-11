import Foundation

enum GotoBusApi{
    case getBeers(page : String)
    case getBeerInfo(item : String)
}

enum NetworkEnvironment { 
    case production
    case desenv
}

extension GotoBusApi : EndPointType{
    var task: HTTPTask {
        switch self {
        case .getBeers:
            return .resquestQuery
        case . getBeerInfo:
            return .resquest
        }
    }

    
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getBeers:
            return .get
        case .getBeerInfo:
            return .get
        }
    }
    
    
    var path: String {
        switch self {
        case .getBeers(let page):
            return page
        case .getBeerInfo(let item):
            return "/\(item)"
        }
    }
        
        
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else{fatalError("Неверно")}
        return url
    }
    
     var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.punkapi.com/v2/beers"
        case .desenv:     return "https://docs.google.com/document/d/18ipEQPJ7In7_Lflt7o9RM1BwwSUnm9h_yr4M_rxs6Pk/edit"
        
        }
    }
    
}



