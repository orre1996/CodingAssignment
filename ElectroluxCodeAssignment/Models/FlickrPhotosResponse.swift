//
//  FlickrPhotosResponse.swift
//  ElectroluxCodeAssignment
//
//  Created by Oscar Berggren on 2021-07-03.
//

import Foundation

struct FlickrPhotosResponse: Codable {
    let page: Int?
    let photos: [Photo]?
}

struct Photo: Codable {
    let url: String
}
