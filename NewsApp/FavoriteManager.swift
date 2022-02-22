//
//  FavoriteManager.swift
//  NewsApp
//
//  Created by Emre Alpago on 22.02.2022.
//

import Foundation

class FavoriteManager {
    
    static let shared = FavoriteManager()
    
    var favoritesNews: [Article] = []
    
    func addFavorite(model:Article){
        //TODO: var olup olmadığını kontrol et, id ile kontrol et
        if !isNewsFind(model: model){
            favoritesNews.append(model)
        }
    }
    
    func isNewsFind(model: Article) -> Bool{
        let filtered = self.favoritesNews.filter { article in
            return article.url == model.url
        }
        if filtered.count > 0 {
            print("Haber Bulundu Filtre")
            return true
        }
        return false
    }
    
    func removeFavorite(model:Article){
        var count = 0;
        for new in favoritesNews {
            if new.url == model.url {
                favoritesNews.remove(at: count)
            }
            count += 1
        }
    }
    
        
    init() {}
}
