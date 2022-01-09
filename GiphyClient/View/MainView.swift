//
//  MainView.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = GifViewModel()
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText, isSearching: $isSearching)
                List(viewModel.gifs) { gif in
                    GifListCell(gif: gif)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Giphy Search")
                
            }
        }
        .onAppear {
            viewModel.getTrendingGifs()
            print("this happened")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
