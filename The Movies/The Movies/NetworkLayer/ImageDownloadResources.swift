//
//  ImageDownloadResources.swift
//  The Movies
//
//  Created by Apple on 04/08/23.
//

import Foundation
protocol ImageDownloadResources {
    func getImageData(imagePath: String, completionHandler:@escaping(_ result: Data?)->Void)
}

struct ImageDownloadAPIResources: ImageDownloadResources {
    func getImageData(imagePath: String, completionHandler:@escaping(_ result: Data?)->Void) {
        guard let imageUrl = URL(string: imagePath) else {
            _ = completionHandler(nil)
            return
        }
        
        APIManager.shared.getImageData(requestUrl: imageUrl) { imageData in
            _ = completionHandler(imageData)
        }
    }
}
