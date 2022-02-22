//
//  SourceData.swift
//  NewsApp
//
//  Created by Emre Alpago on 15.02.2022.
//

import Foundation

class SourceData:Codable{
    var id:String?
    var name:String?
    
    init(id:String?, name:String?){
        self.id = id
        self.name = name
    }
}
