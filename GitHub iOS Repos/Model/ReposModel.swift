//
//  ReposModel.swift
//  GitHub iOS Repos
//
//  Created by Radu Paun on 19/06/2020.
//  Copyright © 2020 Radu Paun. All rights reserved.
//

import Foundation

struct ReposModel : Codable {
    let items : [ItemsModel]
}

struct ItemsModel : Codable {
    let id : Int
    let name : String
    let description : String
    let forks : Int
    let owner : OwnerModel
    let watchers : Int
    let default_branch : String
    let score : Float
    let html_url : String
    let contents_url : String
}

struct OwnerModel : Codable {
    let avatar_url : String
    let type : String
    let login : String
}

