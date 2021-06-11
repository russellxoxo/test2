import Foundation

class  ProjectRepository{
    let networkManager : NetworkManager = NetworkManager()

    func getBeers(_ page : String, _ completion: @escaping (_ res : Data?,_ erro : String?) -> ()) {
        networkManager.getBeers(page) { (data, erro) in
            if erro != nil{
                print(erro!)
                completion(nil,erro!)
            }else{
                if let _data = data {
                    completion(_data,nil)
                    return
                }
                print("Ошибка")
                completion(nil,Warning.parse.rawValue)
            }
        }
    }
    
        
    func getBeersDetail(_ item : String,  completion : @escaping(_ res : Data?, _ erro : String?)->()) {
        networkManager.getBeersDetail(item) { (data, erro) in
            if erro != nil {
                print(erro!)
                completion(nil,erro!)
            }else{
                if let _data = data {
                    completion(_data,nil)
                    return
                }
                print("Ошибка")
                completion(nil,Warning.parse.rawValue)
            }
        }
    }
    
}





