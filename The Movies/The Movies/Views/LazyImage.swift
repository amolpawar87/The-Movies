//
//  LazyImage.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import SwiftUI

struct LazyImage: View {
    static var defaultImage: UIImage = UIImage(named:"placeholder")!
    @ObservedObject var imageDownloader: ImageDownloaderViewModel
    
    init(imageUrl: String) {
        imageDownloader = ImageDownloaderViewModel(imageUrl: imageUrl, imageDownloaderResources: ImageDownloadAPIResources())
    }
    
    var body: some View {
        VStack{
            Image(uiImage: imageDownloader.downloadedImage ?? LazyImage.defaultImage)
                .resizable()
                .scaledToFit()
        }
    }
}

struct LazyImage_Previews: PreviewProvider {
    static var previews: some View {
        LazyImage(imageUrl: "")
    }
}
