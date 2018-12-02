//
//  ViewController.swift
//  frame
//
//  Created by Catie Rencricca on 11/28/18.
//  Copyright © 2018 Catie Rencricca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Data {
        static var mood: String! = ""
        static var activity: String! = ""
        static var genre: String! = ""
    }
    
    var welcomeLabel: UILabel!
    var startButton: UIButton!
    
    let customFont = UIFont(name: "CircularStd-Bold", size: 40)
    let customFontText = UIFont(name: "CircularStd-Bold", size: 30)
    
    let backgroundColor = UIColor(red:0.95, green:0.76, blue:0.81, alpha:1.0)
    let padding: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        welcomeLabel = UILabel()
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.adjustsFontForContentSizeCategory = true
        welcomeLabel.text = "Welcome to Moodify"
        welcomeLabel.font = customFont
        welcomeLabel.numberOfLines = 2
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .black
        view.addSubview(welcomeLabel)
        
        startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = .gray
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 5
        startButton.clipsToBounds = true
        startButton.titleLabel?.font = customFontText
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        view.addSubview(startButton)
        
        setupConstraints()
        NetworkManager.authenticate()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.widthAnchor.constraint(equalToConstant: 300),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 220),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            ])
        
        
    }
    
    @objc func start() {
        let moodViewController = MoodViewController()
        startButton.backgroundColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
        self.navigationController?.pushViewController(moodViewController, animated: true)
    }
    
    
}

