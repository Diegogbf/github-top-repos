//
//  ServiceLayer.swift
//  base-ios
//
//  Created by Diego Gomes on 20/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import Foundation

class ServiceLayer {
    static func request<T: Codable>(route: Router, onSuccess: @escaping (T)->(), onError: @escaping(String)->()) {
        var task: URLSessionTask?
        let session = URLSession(configuration: .default)
        do {
            let request = try self.buildRequest(from: route)
            
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                let httpResponse = response as? HTTPURLResponse
                let result = httpResponse?.handleResponse()
                switch result {
                case .success:
                    if let responseData = data {
                        let apiResponse = try! JSONDecoder().decode(T.self, from: responseData)
                        onSuccess(apiResponse)
                    }
                case .failure(let failure):
                    onError(failure)
                default:
                    break
                }
                
            })
        } catch {
            onError("Internet Error")
        }
        
        task?.resume()
    }
    
    fileprivate static func buildRequest(from route: EndPointType) throws -> URLRequest {
           var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalCacheData
               , timeoutInterval: 10.0)
           request.httpMethod = route.httpMethod.rawValue

           do {
               switch route.task {
               case .request:
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")

               case .requestParameters(bodyParameters: let bodyParameters, urlParameters: let urlParameters):

                   try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)

               case .requestParametersAndHeaders(bodyParameters: let bodyParameters, urlParameters: let urlParameters, additionHeaders: let additionalHeaders):

                   self.addAdditionalHeaders(additionalHeaders, request: &request)
                   try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)

               }
               return request
           } catch {
               throw error
           }
       }

       fileprivate static func configureParameters(bodyParameters: Parameters? , urlParameters: Parameters?, request: inout URLRequest) throws {
           do {
               if let bodyParameters = bodyParameters {
                   try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
               }

               if let urlParameters = urlParameters {
                   try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
               }
           } catch {
               throw error
           }
       }

       fileprivate static func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders? ,request: inout URLRequest) {
           guard let headers = additionalHeaders else { return }
           for (key, value) in  headers {
               request.setValue(value, forHTTPHeaderField: key)
           }
       }
}


