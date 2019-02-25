//
//  AchievementsRouter.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import UIKit

final class AchievementsRouter: AchievementsRouterProtocol {
    static func achievementsModule() -> AchievementsViewController {
        return AchievementsAssembler.assembleModule() as? AchievementsViewController ?? AchievementsViewController()
    }

    func navigateToAchievementDetailsModule(from viewController: UIViewController, forAchievement achievement: AchievementModelProtocol) {
        // Achievement Detail Module
    }

   func navigateToInfoModule(from viewController: UIViewController) {
        // Info Module
    }
}

fileprivate final class AchievementsAssembler {
    static func assembleModule() -> AchievementsViewControllerProtocol {
        let view: AchievementsViewControllerProtocol = AchievementsViewController()
        var presenter: AchievementsPresenterProtocol = AchievementsPresenter()
        let interactor: AchievementsInteractorProtocol = AchievementsInteractor()
        let router: AchievementsRouterProtocol = AchievementsRouter()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        return view
    }
}
