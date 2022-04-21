//
//  HttpUtility.swift
//  Piktale
//
//  Created by Ajeet Sharma on 24/11/21.
import Foundation
import UIKit
struct HttpUtility {
    //MARK:- Create Configuration for URLSession ----
    func createSessionConfiguration()->URLSessionConfiguration{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        return sessionConfig
    }
    //MARK:- GET api call ----
    func getApiData<T:Decodable>(requestUrl:URL, resultType:T.Type, compilationHandler:@escaping(_ result:T)->Void, errorHandler:@escaping(Error)->Void){
        
        let session = URLSession(configuration: self.createSessionConfiguration())
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "GET"
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard  error == nil else{
                errorHandler(error!)
                return
            }
            if data != nil {
                if(data != nil && data?.count != 0){
                    do {
                        print("response")
                        let response = try JSONDecoder().decode(T.self, from: data!)
                        print("response get api - \(response)")
                        compilationHandler(response)
                    }
                    catch let decodingError {
                        debugPrint(decodingError)
                        errorHandler(decodingError)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
}
