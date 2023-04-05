//
//  ProductDetailViewController.swift
//  SearchBarInCollectionViewApi
//
//  Created by Mac on 04/04/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var proiceLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    var product : Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = product!.title
        proiceLabel.text = "₹.\(product!.price)"
        rating.text = "\(product!.rating)"
        
        descLabel.text = "Description : \(product!.description)"
        let urlstring = product!.image
        let url = URL(string: urlstring)
        img.sd_setImage(with: url)
    }
    

}
