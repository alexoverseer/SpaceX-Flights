import Foundation

struct Links: Codable {
    let missionPatch, missionPatchSmall, articleLink, wikipedia: String
    let videoLink: String
    
    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
    }
}
