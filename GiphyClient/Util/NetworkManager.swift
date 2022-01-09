//
//  NetworkManager.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import Foundation
import UIKit


final class NetworkManager {
    static let shared = NetworkManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private let trendingURL = "https://api.giphy.com/v1/gifs/trending?api_key=IwvCw7j2eElDJbSORTdXMac77MsxawP6&limit=25&rating=pg"
    
    
    private init() {}
    
    func getTrendingGifs(completed: @escaping (Result<[GifObject], GifError>) -> Void) {
        guard let url = URL(string: trendingURL) else {
            completed(.failure(.invalidURL))
            return
        }
       
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(GifResponse.self, from: data)
                print(decodedResponse)
                completed(.success(decodedResponse.data))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(fromURLString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: fromURLString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: fromURLString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}


enum GifError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
