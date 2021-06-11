
import Foundation


struct BeerListCellViewModel {
    let lblAvdProduct: String
    let lblProductName: String
    let imageUrl: String
}


class DetailProductViewModel {
    
    let repository      : ProjectRepository
    var showAlerClosure : (()->())?
    var processView     : (()->())?
    private var beer    : Beer = Beer(){
        didSet{
            self.processView?()
        }
    }
    var name, tagline, beerDescription: String?
    var imageURL: String?
    var abv: String?
    var ibu: String?
    
    init() {
        self.repository  = ProjectRepository()
    }
    
    func getProductsDetail(_ id :String){
        self.repository.getBeersDetail(id) { (data, error) in
               if error != nil{
               }
               do{
                   let beer = try? JSONDecoder().decode(Beer.self, from: data!)
                   if let _beer = beer {
                    self.processFetcherBeer(beers: _beer)
                   }
               }
           }
       }
    
    private func processFetcherBeer(beers : Beer){
        self.prepareViewModel(beer:beers[0])
        self.beer = beers
    }
    
    private func prepareViewModel(beer : BeerInfo){
        self.name            = beer.name
        self.tagline         = beer.tagline
        self.beerDescription = beer.beerDescription
        self.imageURL        = beer.imageURL
    }
}
