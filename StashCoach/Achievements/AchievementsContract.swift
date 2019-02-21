//
//  StashCoachContract.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import Foundation

protocol AchievementsViewControllerProtocol: class {
    var presenter: AchievementsPresenterProtocol? { get set }
    func updateTitle(withText text: String)
    func refreshView()
}

protocol AchievementsPresenterProtocol {
    var view: AchievementsViewControllerProtocol? { get set }
    var interactor: AchievementsInteractorProtocol? { get set }
    var router: AchievementsRouterProtocol? { get set }

    var coach: CoachModelProtocol? { get }

    func requestCoachData()
    func numberOfRows() -> Int?
}

protocol AchievementsInteractorProtocol {
    func fetchCoachData(completion: @escaping (_ coach: CoachModelProtocol?, _ error: Error?) -> Void)
}

protocol AchievementsRouterProtocol {
    static func achievementsModule() -> AchievementsViewController
}
