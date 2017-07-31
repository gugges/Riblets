//
//  OKNetworkClientDefault.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

final class OKNetworkClientDefault: OKNetworkClient {
    
    let basePath = "https://www.okcupid.com/"
    
    func request(method: OKNetworkClientRequestMethod, path: String, parameters: [String : Any]?, completion: @escaping (OKNetworkClientResult<Any>) -> Void) {
        
        let components = URLComponents(string: path)
        
        guard let url = components?.url else {
            returnOnMainThread(completion: completion, result: .failure(OKNetworkClientError.malformedURL))
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard let data = data, error == nil
                else {
                    self.returnOnMainThread(completion: completion, result: .failure(error))
                    return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                self.returnOnMainThread(completion: completion, result: .success(json))
                
            } catch {
                self.returnOnMainThread(completion: completion, result: .failure(error))
            }
        }
        
        task.resume()
    }
    
    fileprivate func returnOnMainThread(completion: @escaping (OKNetworkClientResult<Any>) -> Void, result: OKNetworkClientResult<Any>) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
}
