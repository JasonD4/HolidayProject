//
//  GotAnime.swift
//  HolidayProject
//
//  Created by Jason on 12/13/18.
//  Copyright © 2018 Jason. All rights reserved.
//

import Foundation
/*
 "episodeCount": null,
 "episodeLength": 23,
 "totalLength": null,
 "youtubeVideoId": "G_mA6uiNtKw",
 "showType": "TV",
 "nsfw": false
 
 "episodeCount": 366,
 "episodeLength": 1,
 "totalLength": 366,
 "youtubeVideoId": "0yk5H6vvfG4",
 "showType": "TV",
 "nsfw": false
 
 */

struct GotAnime: Codable { // JSONDecoder().decode(GotAnime.self, data)
    let data: [GotAnimeAttributes]
}

struct GotAnimeAttributes: Codable {
    let attributes: AllAttributs
}

struct AllAttributs: Codable {
    let synopsis: String?
    let canonicalTitle: String
    let abbreviatedTitles: [String?]?
    let startDate: String?
    let endDate: String?
    let nextRelease: String?
    let ageRating: String?
    let ageRatingGuide: String?
    let status: String
    let tba: String?
    let posterImage: ImageURL
    let episodeCount: Int?
    let episodeLength: Int?
    let totalLength: Int?
    let nsfw: Bool
    let ja_jp: String?
}

struct ImageURL: Codable {
    let original: URL?
}
