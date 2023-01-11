//
//  Movie.swift
//  Netflix Clone
//
//  Created by Admin on 11/01/23.
//

import Foundation

struct TrandingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

/*
 {
adult = 0;
"backdrop_path" = "/faXT8V80JRhnArTAeYXz0Eutpv9.jpg";
"genre_ids" =             (
 16,
 28,
 12,
 35,
 10751,
 14
);
id = 315162;
"media_type" = movie;
"original_language" = en;
"original_title" = "Puss in Boots: The Last Wish";
overview = "Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.";
popularity = "5525.17";
"poster_path" = "/lmf0zzR7ritjOL3qumRh3hfvOFK.jpg";
"release_date" = "2022-12-07";
title = "Puss in Boots: The Last Wish";
video = 0;
"vote_average" = "8.555999999999999";
"vote_count" = 929;
}
 */
