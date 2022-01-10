//
//  DetailView.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: GifViewModel
    
    var body: some View {
        Button("Press") {
            // do stuff
        }
        .onAppear {
            viewModel.search()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}


