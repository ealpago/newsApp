//
//  APIResponse.swift
//  NewsApp
//
//  Created by Emre Alpago on 15.02.2022.
//

import Foundation


class APIResponse: Codable {
    var status:String?
    var totalResults:Int?
    var articles:[Article]?
    
    init(articles:[Article]?, status:String?, totalResults:Int?){
        self.articles = articles
        self.status = status
        self.totalResults = totalResults
    }
}
