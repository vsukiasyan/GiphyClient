//
//  GifObject.swift
//  GiphyClient
//
//  Created by Vic Sukiasyan on 1/9/22.
//

import Foundation

struct GifObject: Decodable, Identifiable {
    var id: String
    var title: String
    var source_tld: String
    var rating: String
    var url: URL
    var images: Images

    struct Images: Decodable {
      var fixed_height: Image

      struct Image: Decodable {
        var url: URL
        var width: String
        var height: String
      }
    }
}

struct GifResponse: Decodable {
    var data: [GifObject]
}
