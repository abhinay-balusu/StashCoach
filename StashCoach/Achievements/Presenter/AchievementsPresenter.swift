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
    var coach: CoachModelProtocol? {
        didSet {
            achievementViewModels = getAchievementViewModels(forCoach: coach)
        }
    }
    private var achievementViewModels: [AchievementViewModelProtocol] = []

    init(coach: CoachModelProtocol? = nil) {
        self.coach = coach
        achievementViewModels = getAchievementViewModels(forCoach: self.coach)
    }

    func requestCoachData() {
        interactor?.fetchCoachData(completion: { [weak self] (coach, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    self?.view?.showError(withDescription: error?.localizedDescription ?? "")
                    return
                }
                self?.coach = coach
                self?.view?.updateTitle(withText: coach?.overview.title ?? "")
                self?.view?.refreshView()
            }
        })
    }

    func numberOfRows() -> Int {
        return coach?.achievements.count ?? 0
    }

    func achievementViewModel(forRow row: Int) -> AchievementViewModelProtocol? {
        return achievementViewModels[safe: row] ?? nil
    }

    private func getAchievementViewModels(forCoach coach: CoachModelProtocol?) -> [AchievementViewModelProtocol] {
        guard let achievements = coach?.achievements else { return [] }
        achievementViewModels = []
        for achievement in achievements {
            achievementViewModels.append(AchievementViewModel(achievement: achievement))
        }
        return achievementViewModels
    }
}

extension AchievementsPresenter {
    func navigateToAchievementDetailsModule(for row: Int) {
        guard
            let view = view as? AchievementsViewController,
            let achievement = coach?.achievements[safe: row],
            achievement.accessible
        else { return }
        router?.navigateToAchievementDetailsModule(from: view, forAchievement: achievement)
    }

    func navigateToInfoModule() {
        guard
            let view = view as? AchievementsViewController
        else { return }
        router?.navigateToInfoModule(from: view)
    }
}

struct AchievementViewModel: AchievementViewModelProtocol {

    static let ptsSuffix: String = "pts"

    internal let achievement: AchievementModelProtocol

    func achievementLevel() -> String {
        return achievement.level
    }

    func achievementProgress() -> Float {
        return Float(achievement.progress)/Float(achievement.total)
    }

    func achievementProgressValue() -> String {
        return achievement.progress.description + AchievementViewModel.ptsSuffix
    }

    func achievementTotalprogress() -> String {
        return achievement.total.description + AchievementViewModel.ptsSuffix
    }

    func achievementBgImageURL() -> URL? {
        return URL(string: achievement.backgroundImageUrl)
    }

    func achievementAccessibility() -> Bool {
        return achievement.accessible
    }
}
