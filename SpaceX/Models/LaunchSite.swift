import Foundation

struct LaunchSite: Codable {
    let siteID, siteName, siteNameLong: String
    
    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }
}
