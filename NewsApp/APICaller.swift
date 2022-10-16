//
//  APICaller.swift
//  NewsApp
//
//  Created by Shivam Singhal on 16/10/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    struct Constants{
        static let topHeadLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=77400a0c47bc43859553c5e18ac33ba7")
    }
    private init(){}
    
    public func getTopStories(completion: @escaping (Result<[String], Error>) -> Void)
    {
        guard let url = Constants.topHeadLinesURL else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error  = error{
                completion(.failure(error))
            }
            else if let data = data{
                do{
                    let result = try JSONDecoder().decode(String.self, from: data)
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
