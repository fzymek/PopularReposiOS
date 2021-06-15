//
//  RepositoriesResponseModel.swift
//  PopularReposiOS
//
//  Created by Filip on 14/06/2021.
//

import Foundation

struct RepositoriesResponseModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case total_count
        case incomplete_results
        case items
    }
    
    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepositoryModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalCount = try container.decode(Int.self, forKey: .total_count)
        self.incompleteResults = try container.decode(Bool.self, forKey: .incomplete_results)
        self.items = try container.decode([RepositoryModel].self, forKey: .items)
    }
    
    init(totalCount: Int, incompleteResults: Bool, items: [RepositoryModel]) {
        self.totalCount = totalCount
        self.incompleteResults = incompleteResults
        self.items = items
    }
}

struct RepositoryModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case fork
        case language
        case stargazers_count
    }
    
    let id: Int
    let name: String
    let owner: OwnerModel
    let isFork: Bool
    let language: String?
    let starCount: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.owner = try container.decode(OwnerModel.self, forKey: .owner)
        self.isFork = try container.decode(Bool.self, forKey: .fork)
        self.language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        self.starCount = try container.decode(Int.self, forKey: .stargazers_count)
    }
    
    init(id: Int, name: String, owner: OwnerModel, isFork: Bool, language: String?, starCount: Int) {
        self.id = id
        self.name = name
        self.owner = owner
        self.isFork = isFork
        self.language = language
        self.starCount = starCount
    }
}

struct OwnerModel: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatar_url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarUrl = try container.decode(String.self, forKey: .avatar_url)
    }
    
    init(id: Int, login: String, avatarUrl: String) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
    }
}
