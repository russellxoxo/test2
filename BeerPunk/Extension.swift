import Foundation


extension String{
    func getUrlPage(_ page : String) -> String{
        return self.replacingOccurrences(of: "{p}", with: page)
    }
    
}
extension Int{
    func toString() ->String{
        return"\(self)"
    }
}
extension Double{
    func toString() ->String{
        return"\(self)"
    }
}


let BASEURL = "https://api.punkapi.com/v2/beers?page={p}&per_page=25"

