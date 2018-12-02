//
//  NetworkManager.swift
//  frame
//
//  Created by Catie Rencricca on 11/30/18.
//  Copyright © 2018 Adeline Wang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    private static let url = "35.231.87.19/"
    // http://35.231.87.19/playlist/<mood>/<genre>/<activity>
    static func authenticate() {
        let asUrl = URL(string: url)
        UIApplication.shared.open(asUrl!, options: [:])
    }
    
    static func getPlaylist(didGetPlaylist: @escaping (String) -> Void) {
        let playlistURL = "http://35.231.87.19/playlist/" + ViewController.Data.mood + "/" + ViewController.Data.genre + "/" + ViewController.Data.activity
        Alamofire.request(playlistURL, method: .get)
            .validate().responseData { response in
                switch response.result {
                case let .success(data):
                    if let playlist = String(bytes: data, encoding: .utf8) {
                        didGetPlaylist(playlist)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    
}
