//
//  GifListCell.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GifListCell: View {
    let gif: GifObject
    
    var body: some View {
        HStack {
            AnimatedImage(url: URL(string: gif.images.fixed_height.url))
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(gif.title)
                    .font(.title3)
                    .fontWeight(.medium)
                
            }
            .padding(.leading)
        }
    }
}

struct AppetizerListCell_Previews: PreviewProvider {
    static var previews: some View {
        GifListCell(gif: GifMockData.samepleGif)
    }
}

