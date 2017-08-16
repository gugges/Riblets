//
//  OKImageNetworkManager.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/31/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

class OKImageNetworkManager: OKImageNetworkManagerProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func request(url: URL, callback: @escaping (UIImage?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: url) { (data, urlResponse, error) in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    callback(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                callback(image)
            }
        }
        
        task.resume()
        
        return task
    }
    
}
