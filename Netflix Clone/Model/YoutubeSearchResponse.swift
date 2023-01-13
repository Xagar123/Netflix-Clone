//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Admin on 12/01/23.
//

import Foundation



struct YoutubeSearchResponce: Codable {
    
    let items:[VideoElement]
    
}


struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}

/*
 items =     (
             {
         etag = "lk8409-m28s-u0WqMRhDC0vgfsE";
         id =             {
             kind = "youtube#video";
             videoId = 0Dj2kq5Neus;
         };
         kind = "youtube#searchResult";
     },
 */
