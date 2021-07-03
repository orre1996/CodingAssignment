//
//  ImageGalleryViewModel.swift
//  ElectroluxCodeAssignment
//
//  Created by Oscar Berggren on 2021-07-03.
//

import Foundation
import UIKit

class ImageGalleryViewModel: ObservableObject {
    
    var flickrPhotoResponse: FlickrPhotosResponse?
    @Published var images = [UIImage?]()
    
    let networkManager = NetworkManager.shared
    
    func getFlickrImages(searchWord: String = "Electrolux") {
        networkManager.getPhotosFromFlickr(searchWord: searchWord, page: 1, completion: { flickrPhotoResponse in
            if let response = flickrPhotoResponse {
                DispatchQueue.main.async {
                    self.flickrPhotoResponse = response
                    self.addEmptyImages(urls: response.photos?.photo)
                }
            }
        })
    }
    
    func addEmptyImages(urls: [Photo]?) {
        for _ in urls ?? [] {
            images.append(nil)
        }
    }
}
