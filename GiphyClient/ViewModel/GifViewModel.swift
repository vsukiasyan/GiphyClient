//
//  GifViewModel.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import Foundation

final class GifViewModel: ObservableObject {
    @Published var gifs: [GifObject] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    func getTrendingGifs() {
        isLoading = true
        NetworkManager.shared.getTrendingGifs { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let gifs):
                    self.gifs = gifs
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
        
        
    }
    
    func search(searchText: String) {
        isLoading = true
        NetworkManager.shared.search(searchText: searchText) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let gifs):
                    self.gifs = gifs
                    print(gifs)
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
