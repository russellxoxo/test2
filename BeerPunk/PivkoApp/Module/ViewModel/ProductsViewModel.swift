
import Foundation

class ProductsViewModel{
    let repository : ProjectRepository
    private var beers: Beer = Beer()
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    
    private var cellViewModels: [BeerListCellViewModel] = [BeerListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    init() {
        self.repository  = ProjectRepository()
    }
    
    func getProductsFromPage(_ page :String){
        self.isLoading = true
        self.repository.getBeers(page) { (data, error) in
            self.isLoading = false
            if error != nil{
                
            }
            do{
                let beer = try? JSONDecoder().decode(Beer.self, from: data!)
                if let _beer = beer{
                    
                    self.processFetchedBeer(beers: _beer)
                }
            }
        }
        
    }
    
    func userPressed( _ indexPath : IndexPath) -> String{
        return "\(self.beers[indexPath.row].id)"
    }
    
   private func createCellViewModel( beer: BeerInfo ) -> BeerListCellViewModel {
        
     return BeerListCellViewModel( lblAvdProduct: "Подробнее...",
                                       lblProductName: beer.name!,
                                       imageUrl: beer.imageURL!
                                       )
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> BeerListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    private func processFetchedBeer( beers: Beer ) {
        self.beers.append(contentsOf: beers)  // Cache
            var vms = [BeerListCellViewModel]()
            for beer in beers {
                vms.append( createCellViewModel(beer: beer) )
            }
        self.cellViewModels.append(contentsOf: vms)
        }
        
}
    


