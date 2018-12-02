//
//  MoodCollectionViewCell.swift
//  frame
//
//  Created by Adeline Wang on 11/25/18.
//  Copyright © 2018 Adeline Wang. All rights reserved.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    let padding: CGFloat = 15
//    var moodImageView: UIImageView!
    var moodButton: UIButton!
    let customFont = UIFont(name: "CircularStd-Bold", size: 40)
    let customFontText = UIFont(name: "CircularStd-Bold", size: 25)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        moodImageView = UIImageView(frame: .zero)
//        moodImageView.translatesAutoresizingMaskIntoConstraints = false
//        moodImageView.contentMode = .scaleAspectFit
//        contentView.addSubview(moodImageView)
        
        moodButton = UIButton()
        moodButton.translatesAutoresizingMaskIntoConstraints = false
        moodButton.backgroundColor = .clear
        moodButton.setTitleColor(.white, for: .normal)
        moodButton.layer.cornerRadius = 8
        moodButton.clipsToBounds = true
        moodButton.titleLabel?.font = customFontText
        moodButton.layer.borderWidth = 2.0
        moodButton.layer.borderColor = UIColor.gray.cgColor
        //moodButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        contentView.addSubview(moodButton)
        
        self.contentView.isUserInteractionEnabled = false
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            moodButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant:padding),
            moodButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            moodButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            moodButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1 * padding)
            ])
        
        super.updateConstraints()
    }
    
    func configure(for m: Option) {
//        moodImageView.image = UIImage(named: m.profileImageName)
        moodButton.setTitle(m.option, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

