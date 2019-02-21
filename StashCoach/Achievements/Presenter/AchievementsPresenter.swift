//
//  AchievementsPresenter.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import Foundation

final class AchievementsPresenter: AchievementsPresenterProtocol {
    weak var view: AchievementsViewControllerProtocol?
    var interactor: AchievementsInteractorProtocol?
    var router: AchievementsRouterProtocol?
    var coach: CoachModelProtocol?

    init(coach: CoachModelProtocol? = nil) {
        self.coach = coach
    }

    func requestCoachData() {
        interactor?.fetchCoachData(completion: { [weak self] (coach, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self?.coach = coach
                    self?.view?.updateTitle(withText: coach?.overview.title ?? "")
                    self?.view?.refreshView()
                }
            }
        })
    }

    func numberOfRows() -> Int? {
        return coach?.achievements.count
    }
}
