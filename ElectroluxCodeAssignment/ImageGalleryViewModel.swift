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
    @Published var showError = false
    
    let networkManager = NetworkManager.shared
    
    func getFlickrImages(searchWord: String = "Electrolux") {
        networkManager.getPhotosFromFlickr(searchWord: searchWord, page: 1, completion: { flickrPhotoResponse in
            if let response = flickrPhotoResponse {
                DispatchQueue.main.async {
                    self.flickrPhotoResponse = response
                    self.downloadImages(urls: response.photos?.photo)
                }
            } else {
                DispatchQueue.main.async {
                    self.showError = true
                }
            }
        })
    }
    

    func downloadImages(urls: [Photo]?) {
        images.removeAll()
        
        for photo in urls ?? [] {
            if let url = photo.url_m {
                networkManager.getImage(url: url, completion: { image in
                    DispatchQueue.main.async {
                        self.images.append(image)
                    }
                })
            }
        }
    }
    
    func getImage(at index: Int) -> UIImage? {
        return images[safely: index] ?? nil
    }
}
