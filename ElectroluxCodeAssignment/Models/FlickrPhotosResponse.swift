//
//  FlickrPhotosResponse.swift
//  ElectroluxCodeAssignment
//
//  Created by Oscar Berggren on 2021-07-03.
//

import Foundation

struct FlickrPhotosResponse: Codable {
    let photos: Photos?
}

struct Photo: Codable {
    let url_m: String?
}

struct Photos: Codable {
    let page: Int?
    let photo: [Photo]?
}
