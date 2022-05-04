//
//  ImageProvider.swift
//  CacheExample
//
//  Created by Ryan Cummins on 5/3/22.
//

import Foundation
import UIKit

class ImageProvider {
    static let shared = ImageProvider()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        
    }
    
    public func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: NSString(string: urlString)) {
            print("Using Cache")
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            print("Fetching Image")
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self?.cache.setObject(image, forKey: NSString(string: urlString))
                completion(image)
            }
        }
        task.resume()
    }
}
