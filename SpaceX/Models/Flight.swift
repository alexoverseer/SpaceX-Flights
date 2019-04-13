import Foundation

struct Flight: Codable {
    let flightNumber: Int
    let missionName: String
    let missionID: [String]
    let upcoming: Bool
    let launchYear: String
    let launchDateUnix: Double
    let launchDateUTC: String
    let launchDateLocal: String
    let isTentative: Bool
    let tentativeMaxPrecision: String
    let tbd: Bool
    let launchWindow: Int?
    let rocket: Rocket
    let ships: [String]
    let telemetry: Telemetry
    let reuse: Reuse
    let launchSite: LaunchSite
    let launchSuccess: Bool
    let launchFailureDetails: LaunchFailureDetails?
    let links: Links
    let details, staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let timeline: [String: Int]?
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case missionID = "mission_id"
        case upcoming
        case launchYear = "launch_year"
        case launchDateUnix = "launch_date_unix"
        case launchDateUTC = "launch_date_utc"
        case launchDateLocal = "launch_date_local"
        case isTentative = "is_tentative"
        case tentativeMaxPrecision = "tentative_max_precision"
        case tbd
        case launchWindow = "launch_window"
        case rocket, ships, telemetry, reuse
        case launchSite = "launch_site"
        case launchSuccess = "launch_success"
        case launchFailureDetails = "launch_failure_details"
        case links, details
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case timeline
    }
}

struct LaunchFailureDetails: Codable {
    let time: Int
    let altitude: Int?
    let reason: String
}

struct LaunchSite: Codable {
    let siteID: String
    let siteName: String
    let siteNameLong: String
    
    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }
}

struct Reuse: Codable {
    let core, sideCore1, sideCore2, fairings: Bool
    let capsule: Bool
    
    enum CodingKeys: String, CodingKey {
        case core
        case sideCore1 = "side_core1"
        case sideCore2 = "side_core2"
        case fairings, capsule
    }
}

struct Telemetry: Codable {
    let flightClub: String?
    
    enum CodingKeys: String, CodingKey {
        case flightClub = "flight_club"
    }
}
