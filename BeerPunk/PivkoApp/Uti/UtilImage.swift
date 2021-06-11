import Foundation
import UIKit

class UtilImage{
    private var cacheList : [String : Data] = [:]
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(placeHolder : UIImage?, from url: String, _ imageView: UIImageView) {
        let _url = URL(string: url)
        imageView.image = placeHolder
        if self.cacheList[url] != nil{
            print("Использован Кэш")
            imageView.image = UIImage(data: self.cacheList[url]!)
        }else{
            DispatchQueue.global().async {
                print("Загрузка")
                self.getData(from: _url!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print("Загружено")
                    DispatchQueue.main.async() {
                        self.cacheList[url] = data
                        imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    class func downloadImageNoCache(placeHolder : UIImage?, from url: String, _ imageView: UIImageView) {
        let _url = URL(string: url)
        imageView.image = nil
        imageView.image = placeHolder
            DispatchQueue.global().async {
                print("Загрузка")
                URLSession.shared.dataTask(with: _url!) { (data, res, erro) in
                    guard let data = data, erro == nil else { return }
                    print("Загружено")
                    DispatchQueue.main.async() {
                        imageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    
    
    func downloadImage(from url: String, _ imageView: UIImageView, _ completion : @escaping(_ complete : Bool)-> ()) {
        let _url = URL(string: url)
        imageView.image = nil
        if self.cacheList[url] != nil{
            print("Использован Кэш")
            imageView.image = UIImage(data: self.cacheList[url]!)
            completion(true)
        }else{
            print("Загрузка")
            DispatchQueue.global().async {
                self.getData(from: _url!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print("Загружено")
                    DispatchQueue.main.async() {
                        self.cacheList[url] = data
                        imageView.image = UIImage(data: data)
                        completion(true)
                    }
                }
            }
            
        }
    }
    


}
