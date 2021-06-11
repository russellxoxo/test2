import UIKit

class DetailProductView: UIView {

    @IBOutlet weak fileprivate var lblName: UILabel!
    @IBOutlet weak fileprivate var lblTagLine: UILabel!
    @IBOutlet weak fileprivate var lblDescription: UITextView!
    @IBOutlet weak var imgImage: UIImageView!
    
    func lblNameSetText(txt : String){
        self.lblName.text = txt
    }
    func lblTagLineSetText(txt : String){
        self.lblTagLine.text = txt
    }
    func lblDescriptionSetText(txt : String){
        self.lblDescription.text = txt
    }
}
