//
//  AchievementsInteractor.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import Foundation

final class AchievementsInteractor: AchievementsInteractorProtocol {
    func fetchCoachData(completion: @escaping (_ coach: CoachModelProtocol?, _ error: Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let path = Bundle.main.path(forResource: "achievements", ofType: "json") {
                do {
                    let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    if let coach = try? JSONDecoder().decode(Coach.self, from: jsonData) {
                        completion(coach, nil)
                        return
                    }
                    completion(nil, DataParsingError.invalidData)
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
}
