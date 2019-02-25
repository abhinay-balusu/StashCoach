//
//  AchievementsViewController.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

final class AchievementsViewController: UIViewController {
    var presenter: AchievementsPresenterProtocol?

    private struct Constants {
        static let achievementCellIndentifier: String = "AchievementCollectionViewCell"
        static let collectionViewItemHeight: CGFloat = 192
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setNeedsStatusBarAppearanceUpdate()
        configureNavigationBar()
        configureCollectionView()
        presenter?.requestCoachData()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 105/255, green: 62/255, blue: 203/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
    }

    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 20, right: 0)
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib.init(nibName: Constants.achievementCellIndentifier, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.achievementCellIndentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white

        return collectionView
    }()

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        setUpCollectionViewConstraints()
    }

    private func setUpCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    @objc func infoButtonTapped() {
        // Tells Presenter to call router to navigate to info view
    }
}

extension AchievementsViewController: AchievementsViewControllerProtocol {
    func updateTitle(withText text: String) {
        title = text
    }

    func refreshView() {
        collectionView.reloadData()
    }

    func showError(withDescription description: String) {
        // Display Error
    }
}

extension AchievementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.achievementCellIndentifier, for: indexPath) as? AchievementCollectionViewCell,
            let achievementViewModel = presenter?.achievementViewModel(forRow: indexPath.row)
        else { return AchievementCollectionViewCell() }
        cell.configure(withViewModel: achievementViewModel)
        return cell
    }
}

extension AchievementsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let achievementViewModel = presenter?.achievementViewModel(forRow: indexPath.row),
            achievementViewModel.achievementAccessibility()
        else { return }
        // Then only enable it for user interactions
    }
}

extension AchievementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.collectionViewItemHeight)
    }
}

extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
