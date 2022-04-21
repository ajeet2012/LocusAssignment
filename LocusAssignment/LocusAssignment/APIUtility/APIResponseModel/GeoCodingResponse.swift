//
//  GeoCodingResponse.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 21/04/22.
//

import Foundation

// MARK: - GeoCodingResponseElement
struct GeoCodingResponseElement: Codable {
    let name: String?
    let localNames: LocalNames?
    let lat, lon: Double?
    let country, state: String?
    let cod:String?
    let message:String?
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
        case cod
        case message
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let en, zh, mr, ml: String?
    let kn, ar, uk, he: String?
    let ja, hi, gu, pa: String?
    let ms, ru: String?
}

typealias GeoCodingResponse = [GeoCodingResponseElement]
