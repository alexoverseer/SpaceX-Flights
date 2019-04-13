//
//  Rocket.swift
//  SpaceX
//
//  Created by Alexandr Pavlov on 4/14/19.
//  Copyright © 2019 Bananaland. All rights reserved.
//

import Foundation

struct Rocket: Codable {
    let rocketID: String
    let rocketName: String?
    let rocketType: String?
    let firstStage: FirstStage
    let secondStage: SecondStage
    let fairings: Fairings?
    
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case fairings
    }
}

struct FirstStage: Codable {
    let cores: [Core]
}

struct Core: Codable {
    let coreSerial: String
    let flight: Int
    let block: Int?
    let gridfins, legs, reused: Bool
    let landSuccess: Bool?
    let landingIntent: Bool
    let landingType: String?
    let landingVehicle: String?
    
    enum CodingKeys: String, CodingKey {
        case coreSerial = "core_serial"
        case flight, block, gridfins, legs, reused
        case landSuccess = "land_success"
        case landingIntent = "landing_intent"
        case landingType = "landing_type"
        case landingVehicle = "landing_vehicle"
    }
}

struct SecondStage: Codable {
    let block: Int?
    let payloads: [Payload]
}

struct Payload: Codable {
    let payloadID: String
    let noradID: [Int]
    let reused: Bool
    let customers: [String]
    let nationality: String?
    let manufacturer: String?
    let payloadType: String
    let payloadMassKg, payloadMassLbs: Double?
    let orbit: String
    let orbitParams: OrbitParams
    let capSerial: String?
    let massReturnedKg, massReturnedLbs: Double?
    let flightTimeSEC: Int?
    let cargoManifest: String?
    
    enum CodingKeys: String, CodingKey {
        case payloadID = "payload_id"
        case noradID = "norad_id"
        case reused, customers, nationality, manufacturer
        case payloadType = "payload_type"
        case payloadMassKg = "payload_mass_kg"
        case payloadMassLbs = "payload_mass_lbs"
        case orbit
        case orbitParams = "orbit_params"
        case capSerial = "cap_serial"
        case massReturnedKg = "mass_returned_kg"
        case massReturnedLbs = "mass_returned_lbs"
        case flightTimeSEC = "flight_time_sec"
        case cargoManifest = "cargo_manifest"
    }
}

struct Fairings: Codable {
    let reused, recoveryAttempt: Bool
    let recovered: Bool?
    let ship: String?
    
    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt = "recovery_attempt"
        case recovered, ship
    }
}

struct OrbitParams: Codable {
    let referenceSystem: String
    let regime: String?
    let longitude, semiMajorAxisKM, eccentricity, periapsisKM: Double?
    let apoapsisKM, inclinationDeg, periodMin, lifespanYears: Double?
    let epoch: String?
    let meanMotion, raan: Double?
    let argOfPericenter, meanAnomaly: Double?
    
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
        case epoch
        case meanMotion = "mean_motion"
        case raan
        case argOfPericenter = "arg_of_pericenter"
        case meanAnomaly = "mean_anomaly"
    }
}
