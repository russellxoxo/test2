import Foundation


protocol EndPointType {
    var baseURL    : URL        { get }
    var path       : String     { get }
    var httpMethod : HTTPMethod { get }
    var task       : HTTPTask   { get }
}



protocol NetworkRouter {
    associatedtype EndPoint : EndPointType
    func request(_ route: EndPoint, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?)->())
}


class Router<EndPoint : EndPointType> : NetworkRouter{
    private var task : URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let session = URLSession.shared
        do{
            let request = try self.buildRequestApi(url: route)
            if let body = request.httpBody{
                print("URL = \(String(describing: request.url!)) \n \(String(describing: String(data: body, encoding: .utf8) ?? ""))")
            }else{
                 print("URL = \(String(describing: request.url!))")
            }
            task = session.dataTask(with: request, completionHandler: { (data, response, erro) in
                if erro != nil{
                        print("URL = \(String(describing: (erro?.localizedDescription)!))")
                    completion(nil,nil,erro)
                }else{
                    print("URL = \(String(describing: String(data: data!, encoding: .utf8)!))")
                    completion(data, response, erro)
                }
            })
        }catch{
            print("URL = \(String(describing: error.localizedDescription))")
            completion(nil,nil,error)
        }
        
        self.task?.resume()
    }
    
    fileprivate func buildRequestApi( url : EndPoint) throws -> URLRequest{
    
        
        switch url.task {
        case .requestParameters(let parameters):
            var urlRequest = URLRequest(url: url.baseURL.appendingPathComponent(url.path),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 15.0)
            
            let jsonData = try? JSONEncoder().encode(parameters)
            urlRequest.httpBody = jsonData
            urlRequest.httpMethod = url.httpMethod.rawValue
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            return urlRequest
            
        case .resquest:
            var urlRequest = URLRequest(url: url.baseURL.appendingPathComponent(url.path),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 15.0)
            urlRequest.httpMethod = url.httpMethod.rawValue
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            return urlRequest
            
        case.resquestQuery:
            
            var component      = URLComponents(url: url.baseURL, resolvingAgainstBaseURL: false)
            let queryItemQuery = URLQueryItem(name: "page", value: url.path)
            component?.queryItems = [queryItemQuery]

            var urlRequest = URLRequest(url: (component?.url)!,
                                        cachePolicy: .reloadIgnoringLocalCacheData,
                                        timeoutInterval: 15.0)
            
            urlRequest.httpMethod = url.httpMethod.rawValue
            urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            return urlRequest
          
        }
        
    }
    

}


