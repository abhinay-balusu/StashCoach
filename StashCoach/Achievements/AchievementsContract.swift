//
//  StashCoachContract.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import Foundation
import UIKit

protocol AchievementsViewControllerProtocol: class {
    var presenter: AchievementsPresenterProtocol? { get set }
    func updateTitle(withText text: String)
    func refreshView()
    func showError(withDescription description: String)
}

protocol AchievementsPresenterProtocol {
    var view: AchievementsViewControllerProtocol? { get set }
    var interactor: AchievementsInteractorProtocol? { get set }
    var router: AchievementsRouterProtocol? { get set }

    var coach: CoachModelProtocol? { get }

    func requestCoachData()
    func numberOfRows() -> Int
    func achievementViewModel(forRow row: Int) -> AchievementViewModelProtocol?

    func navigateToAchievementDetailsModule(for row: Int)
    func navigateToInfoModule()
}

protocol AchievementsInteractorProtocol {
    /// Data Retrieval
    ///
    /// - Parameter completion: returns optional 'CoachModelProtocol' & optional 'Error'
    func fetchCoachData(completion: @escaping (_ coach: CoachModelProtocol?, _ error: Error?) -> Void)
}

protocol AchievementsRouterProtocol {
    static func achievementsModule() -> AchievementsViewController

    func navigateToAchievementDetailsModule(from viewController: UIViewController, forAchievement achievement: AchievementModelProtocol)
    func navigateToInfoModule(from viewController: UIViewController)
}

protocol AchievementViewModelProtocol {
    var achievement: AchievementModelProtocol { get }

    func achievementLevel() -> String
    func achievementProgress() -> Float
    func achievementProgressValue() -> String
    func achievementTotalprogress() -> String
    func achievementBgImageURL() -> URL?
    func achievementAccessibility() -> Bool
}
