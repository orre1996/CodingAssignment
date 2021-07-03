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
    @Published var showAlert = false
    
    @Published var alertTitle = ""
    @Published var alertBody = ""
    
    let networkManager = NetworkManager.shared
    
    func getFlickrImages(searchWord: String = "Electrolux") {
        networkManager.getPhotosFromFlickr(searchWord: searchWord completion: { [weak self] flickrPhotoResponse in
            if let response = flickrPhotoResponse, !(response.photos?.photo?.isEmpty ?? false) {
                DispatchQueue.main.async {
                    self?.flickrPhotoResponse = response
                    self?.downloadImages(urls: response.photos?.photo)
                }
            } else {
                self?.setAlert(title: "Error", body: "Couldn´t find images for the typed keyword, try something else")
            }
        })
    }
    

    func downloadImages(urls: [Photo]?) {
        images.removeAll()
        
        for photo in urls ?? [] {
            if let url = photo.url_m {
                networkManager.getImage(url: url, completion: { image in
                    DispatchQueue.main.async { [weak self] in
                        self?.images.append(image)
                    }
                })
            }
        }
    }
    
    func getImage(at index: Int) -> UIImage? {
        return images[safely: index] ?? nil
    }
    
    func setAlert(title: String, body: String) {
        DispatchQueue.main.async { [weak self] in
            self?.alertTitle = title
            self?.alertBody = body
            self?.showAlert = true
        }
    }
}
