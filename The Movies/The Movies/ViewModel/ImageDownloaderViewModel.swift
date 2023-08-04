//
//  ImageDownloaderViewModel.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import Foundation
import UIKit

protocol ImageDownloader {
    func getImage()
}

class ImageDownloaderViewModel : ObservableObject, ImageDownloader {
    @Published var downloadedImage: UIImage?
    private let imagePath: String
    private let imageDownloaderResources: ImageDownloadResources
    
    init(imageUrl: String, imageDownloaderResources: ImageDownloadResources) {
        self.imagePath = imageUrl
        self.imageDownloaderResources = imageDownloaderResources
        getImage()
    }

    func getImage() {
        imageDownloaderResources.getImageData(imagePath: self.imagePath) { [weak self] imageData in
            DispatchQueue.main.async {
                guard let imageData = imageData else {
                    return
                }
                let resizedImage = UIImage(data: imageData)?.resizeImage(with: CGSize(width: 100, height: 100))
                self?.downloadedImage = resizedImage
            }
        }
    }
}

extension UIImage {
    func resizeImage(with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))

        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
