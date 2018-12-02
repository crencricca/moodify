//
//  ActivityViewController.swift
//  frame
//
//  Created by Catie Rencricca on 11/27/18.
//  Copyright © 2018 Adeline Wang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ActivityViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var activityCollectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    var activityArray: [Option]!
    var activityViewLabel: UILabel!
    
    let customFont = UIFont(name: "CircularStd-Bold", size: 40)
    let customFontText = UIFont(name: "CircularStd-Bold", size: 30)
    
    var activitySelected: UICollectionViewCell?
    let backgroundColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
    let activityCellReuseIdentifier = "activityCellReuseIdentifier"
    let padding: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        
        let studying = Option(option: "Studying")
        let workout = Option(option: "Exercise")
        let partying = Option(option: "Partying")
        let relaxing = Option(option: "Driving")
        activityArray = [studying, workout, partying, relaxing]
        
        activityViewLabel = UILabel()
        activityViewLabel.translatesAutoresizingMaskIntoConstraints = false
        activityViewLabel.adjustsFontForContentSizeCategory = true
        activityViewLabel.text = "Select An Activity"
        activityViewLabel.font = customFont
        activityViewLabel.numberOfLines = 2
        activityViewLabel.textAlignment = .center
        activityViewLabel.textColor = .white
        view.addSubview(activityViewLabel)
        
        // Setup Collection View
        // UICollectionViewFlowLayout is used to help organize our cells/items into a grid-pattern
        let layout = UICollectionViewFlowLayout()
        // scrollDirection can be vertical or horizontal
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        activityCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        activityCollectionView.translatesAutoresizingMaskIntoConstraints = false
        activityCollectionView.backgroundColor = backgroundColor
        activityCollectionView.dataSource = self
        activityCollectionView.alwaysBounceVertical = true
        activityCollectionView.delegate = self
        //making sure we refresh the page
        activityCollectionView.refreshControl = refreshControl
        activityCollectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: activityCellReuseIdentifier)
        
        let chooseGenreButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(chooseGenre))
        self.navigationItem.rightBarButtonItem = chooseGenreButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

        
        view.addSubview(activityCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityViewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            activityViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            activityCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            activityCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == activityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: activityCellReuseIdentifier, for: indexPath) as! MoodCollectionViewCell
            let activity = activityArray[indexPath.item]
            cell.configure(for: activity)
            cell.setNeedsUpdateConstraints()
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: activityCellReuseIdentifier, for: indexPath) as! MoodCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == activityCollectionView{
            return activityArray.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = activityCollectionView.cellForItem(at: indexPath)
        let cellAsMCVC = activityCollectionView.cellForItem(at: indexPath) as! MoodCollectionViewCell
        ViewController.Data.activity = activityArray[indexPath.row].option
        if (activitySelected == cell) {
            cellAsMCVC.moodButton.backgroundColor = .clear
            activitySelected = nil
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            if(activitySelected != nil) {
                let activitySelectedCell = activitySelected as! MoodCollectionViewCell
                activitySelectedCell.moodButton.backgroundColor = .clear
            }
            cellAsMCVC.moodButton.backgroundColor = .black
            activitySelected = cell!
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
        @objc func chooseGenre() {
            let genreViewController = GenreViewController()
            self.navigationController?.pushViewController(genreViewController, animated: true)
        }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == activityCollectionView {
            let length = (collectionView.frame.width - padding * 3) / 2.0
            let width = (collectionView.frame.height - padding * 4) / 6.0
            return CGSize(width: length, height: width)
        }
        else {
            let length = (collectionView.frame.width - padding * 5) / 3.0
            let width = collectionView.frame.height
            return CGSize(width: length, height: width)
        }
        
    }
}
