//
//  NetworkService.swift
//  NewsApp
//
//  Created by Emre Alpago on 15.02.2022.
//

import Foundation


struct Constant{
    static let API_KEY = "&apiKey=8dae4ea8fff9489bb7fd5ea6e8ac80b7"
    static let baseURL = "https://newsapi.org/v2/"
}

//https://newsapi.org/v2/top-headlines?country=us&apiKey=aaa97f3931c74963b3e9322b891f33d1
//https://newsapi.org/v2/everything?q=bitcoin&apiKey=aaa97f3931c74963b3e9322b891f33d1

public enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


public enum NetworkRouter{
    case country(country:String)
    case everything(search:String)
    
    public var method:HTTPMethod {
        switch self {
        case .country(_):
            return .get
        case .everything:
            return .get
        }
    }
    
    public var path:String{
        switch self {
        case .country(let country):
            return Constant.baseURL + "top-headlines?country=\(country)" + Constant.API_KEY
        case .everything(let everything):
            return Constant.baseURL + "everything?q=\(everything)" + Constant.API_KEY
        }
    }
}



class NetworkManager {
    static let service = NetworkManager()
    public func request<T: Codable>(requestRoute: NetworkRouter, responseModel:T.Type, completion:@escaping (_ details: T) -> Void){
        if let url = URL(string: requestRoute.path){
            var request = URLRequest(url: url)
            request.httpMethod = requestRoute.method.rawValue
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                do {
                    let data = try JSONDecoder().decode(T.self, from: data!)
                    completion(data)
                } catch let e as NSError {
                    print("error : \(e)")
                }
            }
            task.resume()
        }
    }
}



