//
//  MainView.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: GifViewModel
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText, isSearching: $isSearching)
                
                List(viewModel.gifs) { gif in
                    NavigationLink(destination: DetailView()) {
                        GifListCell(gif: gif)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Giphy Search")
                
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
         
            if viewModel.isLoading {
                LoadingView()
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
