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
    var buttonChecked = true
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
        //Bu haber Favoride var mı
        let isFavorite = FavoriteManager.shared.isNewsFind(model: details!)
        self.prepareFavButton(isFav: isFavorite)

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
    
    func prepareFavButton(isFav:Bool){
        favoritesButton?.isSelected = isFav
        if favoritesButton!.isSelected {//Favori ise
            favoritesButton?.setImage(UIImage(named: "favoriteEnable"), for: .normal)
        }else{//değilse
            favoritesButton?.setImage(UIImage(named: "favoriteDisable"), for: .normal)
        }
        
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton){
        if !sender.isSelected {
            if let details = details {
                print("Haber Eklendi")
                FavoriteManager.shared.addFavorite(model: details)
            }
        } else {
            if let details = details {
                FavoriteManager.shared.removeFavorite(model: details)
                print("Haber silindi")
            }
        }
        self.prepareFavButton(isFav: !sender.isSelected)
    }
}
