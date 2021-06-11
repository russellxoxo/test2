import UIKit

class ProductsViewController: UIViewController {
    var pageNo : Int = 1
    lazy var viewModel : ProductsViewModel = {
        return ProductsViewModel()
    }()
    
    
    var mainView : ProductsView{
        get {
            return self.view as! ProductsView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        initViewModel()
        
    }
    func initViewModel(){

        viewModel.reloadTableViewClosure = {[weak self] () in
            DispatchQueue.main.async {
                self!.mainView.prepareTableView()
                
            }
        }
        
        viewModel.updateLoadingStatus = {[weak self]() in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading{
                    self!.mainView.startLoading()
                }else{
                    self!.mainView.stopLoading()
                }
            }
        }
        
        viewModel.getProductsFromPage("1")
    }

}

extension ProductsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductTableViewCell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.beerListCellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vc : DetailProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailProductViewController") as! DetailProductViewController
        vc.id                     = viewModel.userPressed(indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row == viewModel.numberOfCells - 1{
            self.pageNo += 1
            viewModel.getProductsFromPage("\(self.pageNo)")
        }
    }
}



