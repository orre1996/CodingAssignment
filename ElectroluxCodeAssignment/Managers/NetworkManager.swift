//
//  NetworkManager.swift
//  ElectroluxCodeAssignment
//
//  Created by Oscar Berggren on 2021-07-03.
//

import Foundation
import Alamofire

class NetworkManager {
    
    public static let shared = NetworkManager()
    private let apiKey: String
    
    init() {
        
        // Get flickr api key from config file. File located in root of project
        guard let filePath = Bundle.main.path(forResource: "config", ofType: "txt") else {
            apiKey = ""
            assertionFailure("Couldn´t find config file")
            return
        }
        
        guard let fileContent = try? String(contentsOf:  URL(fileURLWithPath: filePath), encoding: String.Encoding.utf8) else {
            apiKey = ""
            assertionFailure("Couldn´t read config file content")
            return
        }
        
        let jsonData = Data(fileContent.utf8)
        let decoder = JSONDecoder()
        
        do {
            let cleanConfigFile = try decoder.decode([String:String].self, from: jsonData)
            guard let flickrApiKey = cleanConfigFile["flickrApiKey"] else {
                apiKey = ""
                assertionFailure("Couldn´t read flickr api key")
                return
            }
            
            apiKey = flickrApiKey
        } catch {
            apiKey = ""
            assertionFailure("Couldn´t decode config file")
            print(error)
        }
    }
    
    func getRequest(url: String, completion: @escaping (Data?) -> ()) {
        if let url = URL(string: url) {
            AF.request(url).responseJSON(completionHandler: { data in
                completion(data.data)
            })
        } else {
            completion(nil)
        }
    }
    
    func getPhotosFromFlickr(searchWord: String, completion: @escaping (FlickrPhotosResponse?) -> ()) {
        
        let url = "https://api.flickr.com/services/rest?\(apiKey)&method=flickr.photos.search&tags=\(searchWord)&format=json&nojsoncallback=true&extras=media&extras=url_sq&extras=url_m&per_page=20&page=1"
        
        getRequest(url: url, completion: { data in
            let decoder = JSONDecoder()
            do {
                if let safeData = data {
                    let photosResponse = try decoder.decode(FlickrPhotosResponse.self, from: safeData)
                    completion(photosResponse)
                } else {
                    print("Couldn´t decode flickr response")
                    completion(nil)
                }
            } catch {
                completion(nil)
                print(error)
            }
        })
    }
}
