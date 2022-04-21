//
//  ApiURL.swift
//  Piktale
//
//  Created by Ajeet Sharma on 29/11/21.
//

import Foundation


struct BaseUrl{
    static let baseURL = "https://api.openweathermap.org"
}

struct EndPoint{
    static let currentWeatherData = "\(BaseUrl.baseURL)/data/2.5/weather?"
    static let directGeoCoding = "\(BaseUrl.baseURL)/geo/1.0/direct?"
}
