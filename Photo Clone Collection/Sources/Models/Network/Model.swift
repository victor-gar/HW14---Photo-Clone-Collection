//
//  Model.swift
//  Photo Clone Collection
//
//  Created by Victor Garitskyu on 13.02.2023.
//

import Foundation

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
    let created_at: String?
    
    enum CodingKeys: String, CodingKey {
           case id
           case created_at = "created_at"
           case urls
       }
}

struct URLS: Codable {
    let thumb: String
}

