//
//  APIManager.swift
//  NewsApp
//
//  Created by Sachin on 18/10/21.
//

import Foundation

struct APIManager {
    
    enum HTTPMethod: String {
        case POST
        case GET
        case PUT
    }
    
    enum APIError: Error {
        case JSONSerialization
        case responseData
        case nilJson
        case timeOut
    }
    
    static let defaultSession = URLSession(configuration: .default)
    
    static var dataTask: URLSessionDataTask?
    
    static let newsAPIURL = "https://newsapi.org/v2/everything?q=tesla&from=2021-09-19&sortBy=publishedAt&apiKey=7f6e1ac9c04448a9b025c48f8f6147fd"
    
    
    static func request(urlRequest: URLRequest, completionHandler: @escaping (_ response: [String: Any]?, _ error: Error?) -> Void) {
        
        dataTask = defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            defer {
                dataTask = nil
            }
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                    return
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, APIError.responseData)
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(nil, APIError.responseData)
                }
                return
            }
            
            var jsonResponse: [String: Any]?
            
            do {
                let json: [String: Any]? = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                DispatchQueue.main.async {
                    guard let json = json else {
                        completionHandler(nil, APIError.responseData)
                        return
                    }
                    jsonResponse = json
                }
            } catch let error{
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completionHandler(nil, APIError.responseData)
                    return
                }
            }
            
            if response.statusCode >= 200 && response.statusCode <= 399 {
                DispatchQueue.main.async {
                    completionHandler(jsonResponse, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(nil, APIError.responseData)
                }
            }
        }
        dataTask?.resume()
    }
    
    static func getUrlRequest(urlString: String, header:[String: String]? ,body: [String: Any]?, httpMethod: APIManager.HTTPMethod) -> URLRequest? {
        
        guard let url = URL(string: urlString) else { return nil }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let header = header {
            for (key, value) in header {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                return nil
            }
            urlRequest.httpBody = httpBody
        }
        
        return urlRequest
    }
    
    static func getNews(completionHandler: @escaping (_ response: [String: Any]?, _ error: Error?) -> Void) {
        let urlString = newsAPIURL
        
        var header = [String: String]()
        header["Content-Type"] = "application/json"
        
        
        guard let urlRequest = APIManager.getUrlRequest(urlString: urlString, header: header, body: nil, httpMethod: .GET) else { return }
        APIManager.request(urlRequest: urlRequest) { (response200, error) in
            DispatchQueue.main.async {
                completionHandler(response200, error)
            }
        }
    }
}
