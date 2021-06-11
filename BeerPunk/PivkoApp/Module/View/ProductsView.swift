import UIKit

class ProductsView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorLoader: UIActivityIndicatorView!
    
    func prepareView(){
        self.tableView.tableFooterView = UIView()
    }
    
    func stopLoading(){
        self.indicatorLoader.stopAnimating()
    }
    func startLoading(){
        self.indicatorLoader.startAnimating()
    }
    func prepareTableView() {
        self.tableView.reloadData()
    }

}
