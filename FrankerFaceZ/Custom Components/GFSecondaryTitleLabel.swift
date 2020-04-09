//
//  GFSecondayTitleLabel.swift
//  GitHub Followers
//
//  Created by John Gers on 3/31/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class GFSecondayTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
      }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
      
    private func configure() {
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.90
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}

