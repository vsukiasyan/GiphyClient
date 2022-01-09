//
//  SearchBarView.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var viewModel: [String]
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search here", text: $searchText)
                    .padding(.leading, 24)
            }.padding()
                .background(Color(.systemGray5))
                .cornerRadius(6)
                .padding(.horizontal)
                .onTapGesture {
                    self.isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        }
                        
                    }
                }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
                
            )
                .transition(.move(edge: .trailing))
                .animation(.spring())
            
            if isSearching {
                Button(action: {
                    self.isSearching = false
                    self.searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    // Make network call here
                    // update viewmodel to new search view
                    viewModel = []
                }) {
                    Text("Search")
                        .padding(.trailing)
                        .padding(.leading, 0)
                }
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(viewModel: .constant(["Testing", "123"]), searchText: .constant("Still Testing..."), isSearching: .constant(true))
    }
}
