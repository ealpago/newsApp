//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Emre Alpago on 17.02.2022.
//

import UIKit
import SafariServices


class DetailsViewController: UIViewController {
    
    @IBOutlet var detailsImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var descriptionLabel: UITextView?
    @IBOutlet var authorButton: UIButton?
    @IBOutlet var publishDateButton: UIButton?
    @IBOutlet var favoritesButton: UIButton?
    @IBOutlet var sharedButton: UIButton?
    @IBOutlet var backButton: UIButton?
    @IBOutlet var webSourceButton: UIButton?
    var buttonChecked = false
    var details:Article?
    var url:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func initialize(details:Article){
        self.details = details
    }
    
    func setupUI() {
        titleLabel?.text = details?.title
        descriptionLabel?.text = details?.description
        detailsImageView?.downloaded(from: (details?.urlToImage)!)
        url = (details?.url)!
        authorButton?.setTitle(details?.author, for: .normal)
        publishDateButton?.setTitle(details?.publishedAt, for: .normal)
        authorButton?.isEnabled = false
        publishDateButton?.isEnabled = false
    }
    
    @IBAction func webSourceButtonTapped(_ sender: UIButton) {
        print("tapped")
        guard let webUrl = URL(string: url) else {
            return
        }
        let vc = SFSafariViewController(url: webUrl)
        present(vc, animated: true)
    }
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteButtonTapped(){
        print("ButtonTapped")
        print(details?.title as Any)
        if let details = details {
            FavoritesViewController.favoritesNews.append(details)
        }
    }
}

//extension DetailsViewController:FavoriteViewControllerDelegate{
//    func addFavorites(model: Article) {
//
//    }
//}