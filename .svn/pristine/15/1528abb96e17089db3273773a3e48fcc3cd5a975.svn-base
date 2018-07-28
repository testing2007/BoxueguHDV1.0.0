//
//  BXGMoyaWrap.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/10.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import Alamofire
import Moya

public enum BXGRequestMothod {
    case get
    case post
}

public protocol BXGTargetType: TargetType {
    
    // parser
    var parser: BXGNetworkAPIParser { get }
    // cache policy
    var cachePolicy: NetworkCachePolicy { get }
    
    var parameters: [String:Any]? { get }
    
    var requestMethod: BXGRequestMothod { get }
}

extension BXGTargetType {
    var requestMethod: BXGRequestMothod {
        return .post
    }
}

extension BXGTargetType {
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
    }
    
    var method: Moya.Method { // 这个重新封装
        
        switch self.requestMethod {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
    
    var task: Moya.Task { // 这个重新封装
        
        var parameters = [String:Any]()
        
        if let fromParameters = self.parameters {
            for e in fromParameters {
                parameters[e.key] = fromParameters[e.key]
            }
        }
        return Task.requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
}

public enum NetworkResponse {
    case success(status: Int, message: String, result: Any?)
    case failure(error: Error)
}

public enum NetworkCachePolicy {
    case none
    case loadFailedReturnCacheData
}

public protocol BXGNetworkAPIParser {
    func parse(_ data: Data) -> NetworkResponse
}

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

public typealias NetworkMethod = Alamofire.HTTPMethod
public typealias NetworkTask = Alamofire.HTTPMethod

protocol BXGProviderDelegate {
    var commonParameter: [String: Any]? { get }
    var commonHeader: [String: String]? { get }
}

protocol BXGNetworkPulginType {
    func didReceive(response: NetworkResponse)
}
extension BXGNetworkPulginType {
    func didReceive(response: NetworkResponse) {}
}

public class BXGProvider<Target: BXGTargetType> {
    var delegate: BXGProviderDelegate?
    
    func request(api:Target, response: @escaping (NetworkResponse) -> (),  plugins: [BXGNetworkPulginType]) {
        let provider = MoyaProvider<Target>(endpointClosure: self.bxgEndpointMapping, requestClosure: { (endpoint, finished) in
            if var request = try? endpoint.urlRequest() {
                request.timeoutInterval = 10;
                finished(.success(request))
            }
        },plugins: [NetworkLoggerPlugin(verbose: true)])
//        let provider = MoyaProvider<Target>(endpointClosure: self.bxgEndpointMapping, plugins: [NetworkLoggerPlugin(verbose: true)])
        
        provider.request(api) { (result) in
            switch result {
            case let .success(moyaResponse):
                
                
                let re = api.parser.parse(moyaResponse.data)
                for plug in plugins {
                    plug.didReceive(response: re)
                }
                
                response(re)
                // 在这里 使用  parser
            case let .failure(error):
                response(.failure(error: error))
                // 在这里 使用  parser
            }
        }
    }
    
    public func bxgEndpointMapping(for target: Target) -> Endpoint {
        
        var task:Task = target.task
        
        var finalParameters: [String:Any] = [String:Any]()
        if let d = self.delegate, let commonParameters = d.commonParameter {
            
            for e in commonParameters {
                finalParameters[e.key] = commonParameters[e.key];
            }
        }
        
        switch target.task {
        case let .requestParameters(parameters: parameters, encoding: encoding):
            for e in parameters {
                finalParameters[e.key] = parameters[e.key];
            }
            task = .requestParameters(parameters: finalParameters, encoding: encoding)
        default: break
        }
        
        var finalHeaders = Dictionary<String, String>()
        
        if let d = self.delegate, let commonHeaders = d.commonHeader {
            
            for e in commonHeaders {
                finalHeaders[e.key] = commonHeaders[e.key];
            }
        }
        
        let headers = target.headers
        
        if let headers = headers {
            for e in headers {
                finalHeaders[e.key] = headers[e.key]
            }
        }
        
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: task,
            httpHeaderFields: finalHeaders
        )
    }
}
