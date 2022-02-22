//
//  ArticleData.swift
//  NewsApp
//
//  Created by Emre Alpago on 15.02.2022.
//

import Foundation

class Article:Codable {
    var source:SourceData?
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
    
    init(source:SourceData?, author:String?, title:String?, description:String?, url:String?, urlToImage:String?, publishedAt:String?, content:String?){
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
