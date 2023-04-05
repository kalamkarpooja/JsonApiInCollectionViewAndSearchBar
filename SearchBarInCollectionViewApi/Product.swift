//
//  Product.swift
//  SearchBarInCollectionViewApi
//
//  Created by Mac on 04/04/23.
//

import Foundation
    struct Product: Codable {
        let id: Int
        let title: String
        let price: Double
        let description: String
        let category: Category
        let image: String
        let rating: Rating
    }
       enum Category: String, Codable {
        case electronics = "electronics"
        case jewelery = "jewelery"
        case menSClothing = "men's clothing"
        case womenSClothing = "women's clothing"
    }
//mark : rating
    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
