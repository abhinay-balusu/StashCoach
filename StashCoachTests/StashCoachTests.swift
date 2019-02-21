//
//  StashCoachTests.swift
//  StashCoachTests
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import XCTest
@testable import StashCoach

final class AchievementsInteractorMock: AchievementsInteractorProtocol {
    var fetchCoachDataCalled: Bool = false
    func fetchCoachData(completion: @escaping (CoachModelProtocol?, Error?) -> Void) {
        fetchCoachDataCalled = true
    }
}

class AchievementsPresenterTests: XCTestCase {

    var presenter: AchievementsPresenterProtocol! = nil
    var interactor: AchievementsInteractorMock! = nil

    override func setUp() {
        presenter = AchievementsPresenter()
        interactor = AchievementsInteractorMock()

        presenter.interactor = interactor
    }

    override func tearDown() {
        presenter = nil
        interactor = nil
    }

    func testInitialization() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertNotNil(interactor)
        XCTAssertNil(presenter.coach)
    }

    func testRequestData() {
        presenter.requestCoachData()
        XCTAssert(interactor.fetchCoachDataCalled)
    }

    func testDataSource() {
        presenter = AchievementsPresenter(coach: Coach(success: true, status: 200, overview: Overview(title: "Smart Investing"), achievements: [Achievement(id: 1, level: "1", progress: 10, total: 50, backgroundImageUrl: "url", accessible: true)]))
        XCTAssertNotNil(presenter.coach)
        XCTAssert(presenter.numberOfRows() == 1)
        XCTAssertNotNil(presenter.achievementViewModel(forRow: 0))
    }
}

class AcievementsInteractorTests: XCTestCase {

    var interactor: AchievementsInteractorProtocol! = nil

    override func setUp() {
        interactor = AchievementsInteractor()
    }

    override func tearDown() {
        interactor = nil
    }

    func testInitialization() {
        XCTAssertNotNil(interactor)
    }

    func testFetchData() {
        var coach: CoachModelProtocol?
        let expectation = self.expectation(description: "Data Retrieval")
        interactor.fetchCoachData { (coachObject, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(coachObject)
            coach = coachObject
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(coach)
        XCTAssert(coach?.achievements.count == 3)
    }
}

class AchievementsRouterTests: XCTestCase {
    func testRouterModule() {
        XCTAssertNotNil(AchievementsRouter.achievementsModule())
        let vc = AchievementsRouter.achievementsModule()
        XCTAssertNotNil(vc.presenter)
        XCTAssertNotNil(vc.presenter?.interactor)
        XCTAssertNotNil(vc.presenter?.router)
        XCTAssertNil(vc.presenter?.coach)
    }
}

final class AchievementsPresenterMock: AchievementsPresenterProtocol {
    var view: AchievementsViewControllerProtocol?
    var interactor: AchievementsInteractorProtocol?
    var router: AchievementsRouterProtocol?
    var coach: CoachModelProtocol?

    init() {
        coach = Coach(success: true, status: 200, overview: Overview(title: "Smart Investing"), achievements: [Achievement(id: 1, level: "1", progress: 10, total: 50, backgroundImageUrl: "url", accessible: true)])
    }

    var requestCoachDataCalled: Bool = false
    func requestCoachData() {
        requestCoachDataCalled = true
    }

    func numberOfRows() -> Int? {
        return coach?.achievements.count
    }

    func achievementViewModel(forRow row: Int) -> AchievementViewModelProtocol? {
        return AchievementViewModel(achievement: Achievement(id: 1, level: "1", progress: 10, total: 50, backgroundImageUrl: "url", accessible: true))
    }
}

class AchievementsViewControllerTests: XCTestCase {
    var view: AchievementsViewController! = nil
    var presenter: AchievementsPresenterMock! = nil

    override func setUp() {
        view = AchievementsViewController()
        presenter = AchievementsPresenterMock()

        view.presenter = presenter
        view.viewDidLoad()
    }

    override func tearDown() {
        view = nil
        presenter = nil
    }

    func testInitialization() {
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.presenter)
        XCTAssert(presenter.requestCoachDataCalled)
    }

    func testCollectionView() {
        XCTAssert(view.conforms(to: UICollectionViewDataSource.self))
        XCTAssert(view.conforms(to: UICollectionViewDelegateFlowLayout.self))
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = view.self
        XCTAssert(view.collectionView(collectionView, numberOfItemsInSection: 0) == 1)
    }

    func testScreenTitle() {
        view.updateTitle(withText: "Stash")
        XCTAssertNotNil(view.title)
        XCTAssert(view.title == "Stash")
    }

    func testAchievementsViewModel() {
        let achievementViewModel = presenter.achievementViewModel(forRow: 0)
        XCTAssertNotNil(achievementViewModel)
        XCTAssert(achievementViewModel?.achievementLevel() == "1")
        XCTAssert(achievementViewModel?.achievementProgress() == 0.2)
        XCTAssert(achievementViewModel?.achievementAccessibility() == true)
        XCTAssert(achievementViewModel?.achievementProgressValue() == "10pts")
        XCTAssert(achievementViewModel?.achievementTotalprogress() == "50pts")
        XCTAssertNotNil(achievementViewModel?.achievementBgImageURL())
    }
}
