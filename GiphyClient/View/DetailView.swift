//
//  DetailView.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: GifViewModel
    var id: String
    
    
    var body: some View {
        VStack {
            AnimatedImage(url: URL(string: viewModel.gif2["data"]?.images.fixed_height.url ?? "https://media1.giphy.com/media/bq2Nk0o7bQhhseGATA/200.gif?cid=772e549406ee18dbd878be83de4080df4e680814ceb2860e&rid=200.gif&ct=g"))
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 200)
                .cornerRadius(8)
            
            
            Text(viewModel.gif2["data"]?.title ?? "Blarh")
            Text(viewModel.gif2["data"]?.rating ?? "blarhg")
            Text(viewModel.gif2["data"]?.source_tld ?? "blarhg")
            Spacer()
        }
        
        
        .onAppear {
            viewModel.getGifByID(id: id)
            print(id)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: "12445")
    }
}


