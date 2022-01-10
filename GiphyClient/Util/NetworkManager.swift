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
    
    private let baseURL = "https://api.giphy.com/v1/gifs/"
    private let trendingURL = "trending?api_key=IwvCw7j2eElDJbSORTdXMac77MsxawP6&limit=25&rating=pg"
    private let searchURL = "search?api_key=IwvCw7j2eElDJbSORTdXMac77MsxawP6&limit=25&offset=0&rating=pg&lang=en&q="
    private let gifByID = "?api_key=IwvCw7j2eElDJbSORTdXMac77MsxawP6"
    
    private init() {}
    
    func getTrendingGifs(completed: @escaping (Result<[GifObject], GifError>) -> Void) {
        guard let url = URL(string: baseURL + trendingURL) else {
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
                completed(.success(decodedResponse.data))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func search(searchText: String, completed: @escaping (Result<[GifObject], GifError>) -> Void) {
        let fullSearchURL = baseURL + searchURL + searchText
        
        guard let url = URL(string: fullSearchURL) else {
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
                completed(.success(decodedResponse.data))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getGifByID(id: String, completed: @escaping (Result<GifObject, GifError>) -> Void) {
        guard let url = URL(string: baseURL + id + gifByID) else {
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
                let decodedResponse = try decoder.decode(GifResponse2.self, from: data)
                completed(.success(decodedResponse.data))
            } catch {
                completed(.failure(.invalidData))
            }
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
