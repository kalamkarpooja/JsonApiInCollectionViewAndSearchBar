//
//  ViewController.swift
//  SearchBarInCollectionViewApi
//
//  Created by Mac on 04/04/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate {
    var products = [Product]()
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
           jsonParser()
           registerCell()
           searchBarSetup()
    }
    func registerCell(){
        let uinib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.productCollectionView.register(uinib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    func jsonParser(){
        let urlString = "https://fakestoreapi.com/products"
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest){data ,response,error in
            print(String(data: data!, encoding: .utf8)!)
            print(response)
            let jsonDecoder = JSONDecoder()
            let productResponse = try! jsonDecoder.decode([Product].self, from: data!)
            self.products = productResponse
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }.resume()
    }

    private func searchBarSetup(){
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    navigationItem.searchController = searchController
   }
}
  extension ViewController: UISearchResultsUpdating{
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else {return}
    if searchText == ""{
        jsonParser()
    }else{
        products = products.filter{
            $0.title.contains(searchText)
            }
    }
    productCollectionView.reloadData()
}
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.idLabel.text = "\(products[indexPath.row].id)"
        cell.titleLabel.text = products[indexPath.row].title
        let urlstring = products[indexPath.row].image
        let url = URL(string: urlstring)
        cell.img.sd_setImage(with: url)
        cell.layer.borderWidth = 5
        cell.layer.borderColor = .init(genericCMYKCyan: 2, magenta: 2, yellow: 2, black: 3, alpha: 3)
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 250, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        detailVC.product = products[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
