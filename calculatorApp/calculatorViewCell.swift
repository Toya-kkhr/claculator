//
//  calculatorViewCell.swift
//  calculatorApp
//
//  Created by 加古原　冬弥 on 2020/06/12.
//  Copyright © 2020 加古原　冬弥. All rights reserved.
//

import Foundation
import UIKit

class CalculatorViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.numberLabel.alpha = 0.3
            }else{
                self.numberLabel.alpha = 1
            }
        }
    }
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "1"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.clipsToBounds = true
        label.backgroundColor = .orange
        return label
    
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        addSubview(numberLabel)
        
        //backgroundColor = .black
        
        numberLabel.frame.size = self.frame.size
        numberLabel.layer.cornerRadius = self.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

