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
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void)
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
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


// Models

struct APIResponse: Codable{
    let articles: [Article]
}


struct Article: Codable{
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage : String?
    let publishedAt: String
}

struct Source: Codable{
    let name: String
}
