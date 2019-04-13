//
//  Links.swift
//  SpaceX
//
//  Created by Alexandr Pavlov on 4/14/19.
//  Copyright © 2019 Bananaland. All rights reserved.
//

import Foundation

struct Links: Codable {
    let missionPatch, missionPatchSmall: String
    let redditCampaign: String?
    let redditLaunch: String?
    let redditRecovery, redditMedia: String?
    let presskit: String?
    let articleLink: String
    let wikipedia: String?
    let videoLink: String
    let youtubeID: String
    let flickrImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case redditCampaign = "reddit_campaign"
        case redditLaunch = "reddit_launch"
        case redditRecovery = "reddit_recovery"
        case redditMedia = "reddit_media"
        case presskit
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case youtubeID = "youtube_id"
        case flickrImages = "flickr_images"
    }
}
