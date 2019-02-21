//
//  AchievementCollectionViewCell.swift
//  StashCoach
//
//  Created by Abhinay Balusu on 2/20/19.
//  Copyright © 2019 abhinay. All rights reserved.
//

import UIKit

final class AchievementCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var levelIndicatorView: UIView!
    @IBOutlet weak var levelValuelabel: UILabel!
    @IBOutlet weak var progressBar: StashProgressView!
    @IBOutlet weak var progressvalueLabel: UILabel!
    @IBOutlet weak var totalProgressIndicatorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        levelIndicatorView.alpha = 0.7
        levelIndicatorView.layer.cornerRadius = levelIndicatorView.frame.width/2
        bgImageView.layer.cornerRadius = 12
        bgImageView.clipsToBounds = true
    }
}

final class StashProgressView: UIProgressView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }
}
