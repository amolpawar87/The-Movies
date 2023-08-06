//
//  APIManager.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    private init(){}
    
    func getImageData(requestUrl: URL, completionHandler:@escaping(_ result: Data?)-> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "get"
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let imageData = data else {
                completionHandler(nil)
                return
            }
            completionHandler(imageData)
        }.resume()
    }
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void) {

        let token = API_ACCESS_TOKEN.getAccessToken()
        
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String = "Bearer \(token)"
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue]
        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        session.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            guard let response = responseData else {
                _=completionHandler(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: response)
                _=completionHandler(result)
            }
            catch let error{
                debugPrint("error occured while decoding = \(error)")
                _=completionHandler(nil)
            }
        }.resume()
    }
}
