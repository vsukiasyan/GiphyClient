//
//  MainView.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import SwiftUI

struct MainView: View {
    @State var viewModel = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen"]
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(viewModel: $viewModel, searchText: $searchText, isSearching: $isSearching)
                List(viewModel, id: \.self) {
                    Text($0)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Giphy Search")
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
