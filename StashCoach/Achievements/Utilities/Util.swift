//
//  ImageCaching.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import Foundation
import UIKit

enum DataParsingError: Error {
    case invalidData
}

extension DataParsingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidData:
            return NSLocalizedString("Data parsing error", comment: "Inavalid Data Received")
        }
    }
}
