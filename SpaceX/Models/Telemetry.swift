import Foundation

struct Telemetry: Codable {
    let flightClub: String?
    
    enum CodingKeys: String, CodingKey {
        case flightClub = "flight_club"
    }
}
