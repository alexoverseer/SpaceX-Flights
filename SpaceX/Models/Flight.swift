struct Flight: Codable {
    let flightNumber: Int
    let missionName, launchYear: String
    let launchDateUnix: Double
    let launchDateUTC, launchDateLocal: String
    let rocket: Rocket
    let telemetry: Telemetry
    let reuse: Reuse
    let launchSite: LaunchSite
    let launchSuccess: Bool
    let links: Links
    let details: String?
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case launchDateUnix = "launch_date_unix"
        case launchDateUTC = "launch_date_utc"
        case launchDateLocal = "launch_date_local"
        case rocket, telemetry, reuse
        case launchSite = "launch_site"
        case launchSuccess = "launch_success"
        case links, details
    }
}
