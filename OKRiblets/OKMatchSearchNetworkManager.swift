//
//  OKMatchSearchNetworkManager.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

final class OKMatchSearchNetworkManager {
    
    fileprivate let client: OKNetworkClient
    fileprivate let relativePath = "matchSample.json"
    fileprivate var path: String { return "\(client.basePath)\(relativePath)" }
    
    init(client: OKNetworkClient = OKNetworkClientDefault()) {
        self.client = client
    }
    
    func getMatches(completion: @escaping (OKNetworkClientResult<[OKUser]>) -> Void) {
        client.request(method: .get, path: path, parameters: nil) { (result) in
            
            switch result {
            case .success(let response):
                completion(self.parseGetMatches(response: response))
                
            case .failure(let errors):
                completion(.failure(errors))
            }
        }
    }
    
    fileprivate func parseGetMatches(response: Any) -> OKNetworkClientResult<[OKUser]> {
        if let dictionary = response as? [AnyHashable : Any], let array = dictionary["data"] as? [[AnyHashable : Any]] {
            let users = array.flatMap(OKUserParser().parse)
            return .success(users)
        }
        
        return .failure(OKNetworkClientError.unparsableModel)
    }
    
}
