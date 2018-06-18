import Foundation

struct Rocket: Codable {
    let rocketID, rocketName, rocketType: String
    let firstStage: FirstStage
    let secondStage: SecondStage
    
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
    }
}

struct FirstStage: Codable {
    let cores: [Core]
}

struct SecondStage: Codable {
    let block: Int?
    let payloads: [Payload]
}

struct Core: Codable {
    let coreSerial: String
    let flight: Int
    let block: Int?
    let reused, landSuccess: Bool?
    let landingType: String?
    let landingVehicle: String?
    
    enum CodingKeys: String, CodingKey {
        case coreSerial = "core_serial"
        case flight, block, reused
        case landSuccess = "land_success"
        case landingType = "landing_type"
        case landingVehicle = "landing_vehicle"
    }
}

struct Payload: Codable {
    let payloadID: String
    let reused: Bool
    let customers: [String]
    let payloadType: String
    let payloadMassKg: Double?
    let payloadMassLbs: Double?
    let orbit: String
    let orbitParams: OrbitParams
    
    enum CodingKeys: String, CodingKey {
        case payloadID = "payload_id"
        case reused, customers
        case payloadType = "payload_type"
        case payloadMassKg = "payload_mass_kg"
        case payloadMassLbs = "payload_mass_lbs"
        case orbit
        case orbitParams = "orbit_params"
    }
}

struct OrbitParams: Codable {
    let referenceSystem, regime: String?
    let longitude: Double?
    let semiMajorAxisKM: Double?
    let eccentricity: Double?
    let periapsisKM: Double?
    let apoapsisKM: Double?
    let inclinationDeg: Double?
    let periodMin: Double?
    let lifespanYears: Int?
    
    enum CodingKeys: String, CodingKey {
        case referenceSystem = "reference_system"
        case regime, longitude
        case semiMajorAxisKM = "semi_major_axis_km"
        case eccentricity
        case periapsisKM = "periapsis_km"
        case apoapsisKM = "apoapsis_km"
        case inclinationDeg = "inclination_deg"
        case periodMin = "period_min"
        case lifespanYears = "lifespan_years"
    }
}
