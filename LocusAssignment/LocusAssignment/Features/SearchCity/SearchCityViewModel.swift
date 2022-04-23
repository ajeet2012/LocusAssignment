//
//  SearchCityViewModel.swift
//  LocusAssignment
//
//  Created by Ajeet Sharma on 21/04/22.
//

import Foundation

class SearchCityViewModel{
    
    var model:SearchCityModel = SearchCityModel()
    
    
    
    func callGeoCodingUsingCityName(successHandler:@escaping()->Void, errorHandler:@escaping(Error)->Void){
        
        guard let cityName = model.cityName else {
            return
        }
        
        let urlString = "\(EndPoint.directGeoCoding)q=\(cityName)&limit=10&appid=\(Constants.apiKey)"
        
        print("URL string - \(urlString)")
        
        guard let urlObj = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else{
            return
        }
        
        print("Call api -")
        
        HttpUtility().getApiData(requestUrl: urlObj, resultType: GeoCodingResponse.self) { (response) in
            
            self.model.response = response
            successHandler()
            
        } errorHandler: { (error) in
            errorHandler(error)
        }
    }
}
