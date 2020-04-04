//
//  CircleView.swift
//  CircleSpawn
//
//  Created by Best Mac on 04.04.2020.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    init(color: UIColor, center: CGPoint) {
        let size: CGFloat = 100
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        self.backgroundColor = color
        self.center = center
        self.layer.cornerRadius = size * 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
