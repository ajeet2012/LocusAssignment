//
//  WeatherViewModel.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 21/04/22.
//

import Foundation

class WeatherListViewModel {
    var model:WeatherListModel = WeatherListModel()

    
    func apiCallToFetchWeatherReport(successHandler:@escaping()->Void, errorHandler:@escaping(Error)->Void){
      
        let urlString = "\(EndPoint.currentWeatherData)lat=\(self.model.lat)&lon=\(self.model.lon)&appid=\(Constants.apiKey)"
        
        print("URL string - \(urlString)")
        
        guard let urlObj = URL(string: urlString) else{
            return
        }
        
        print("Call api -")
        
        HttpUtility().getApiData(requestUrl: urlObj, resultType: CurrentWheatherDataResponse.self) { (response) in
            
            self.model.response = response
            successHandler()
            
        } errorHandler: { (error) in
            errorHandler(error)
        }
    }
}
