//
//  CoachEntity.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import Foundation

protocol AchievementModelProtocol: Decodable {
    var id: Int { get }
    var level: String { get }
    var progress: Int { get }
    var total: Int { get }
    var backgroundImageUrl: String { get }
    var accessible: Bool { get }
}

struct Achievement: AchievementModelProtocol {
    let id: Int
    let level: String
    let progress: Int
    let total: Int
    let backgroundImageUrl: String
    let accessible: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case level
        case progress
        case total
        case backgroundImageUrl = "bg_image_url"
        case accessible
    }
}

protocol OverviewModelProtocol: Decodable {
    var title: String { get }
}

struct Overview: OverviewModelProtocol {
    let title: String
}

protocol CoachModelProtocol: Decodable {
//    associatedtype A = AchievementModelProtocol
//    associatedtype O = OverviewModelProtocol
    var success: Bool { get }
    var status: Int { get }
    var overview: Overview { get }
    var achievements: [Achievement] { get }
}

//struct Coach<A: AchievementModelProtocol, O: OverviewModelProtocol>: CoachModelProtocol
struct Coach: CoachModelProtocol {
    let success: Bool
    let status: Int
    let overview: Overview
    let achievements: [Achievement]
}
