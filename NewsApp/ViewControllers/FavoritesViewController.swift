//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Emre Alpago on 17.02.2022.
//

import UIKit

//protocol FavoriteViewControllerDelegate{
//    func addFavorites(model:Article)
//}

//How to add favorites with singleton
//singleton instance
//addFavorites
//removeFavorites
//select-deselect

class FavoritesViewController: UIViewController {
        
    @IBOutlet var favoriteTableView: UITableView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteTableView.estimatedRowHeight = 120.0
        title = "Favorites"
        favoriteTableView.dataSource = self
        
        favoriteTableView.register(UINib(nibName: K.cellNibName , bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
}

extension FavoritesViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteManager.shared.favoritesNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! NewsTableViewCell
        let model = FavoriteManager.shared.favoritesNews[indexPath.row]
        cell.initiliaze(cellModel: model)
        cell.delegate = self
        cell.layoutIfNeeded()
        return cell
    }
}

extension FavoritesViewController:TableViewCellDelegate{
    func didselectItem(model: Article) {
        print("\(model.title ?? "")")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.initialize(details: model)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}



