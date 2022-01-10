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
    var url: String
    var images: Images

    struct Images: Decodable {
      var fixed_height: Image

      struct Image: Decodable {
        var url: String
        var width: String
        var height: String
      }
    }
}

struct GifResponse: Decodable {
    var data: [GifObject]
}

struct GifResponse2: Decodable {
    var data: GifObject
}

struct GifMockData {
    
    static let samepleGif = GifObject(id: "kMI3z7b9RWrYQbsXd2",
                                      title: "Test Title",
                                      source_tld: "",
                                      rating: "g",
                                      url: "https://giphy.com/gifs/kMI3z7b9RWrYQbsXd2",
                                      images: GifObject.Images(fixed_height: GifObject.Images.Image(url: "https://giphy.com/gifs/kMI3z7b9RWrYQbsXd2", width: "200", height: "200")))
}
