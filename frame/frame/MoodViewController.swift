//
//  MoodViewController.swift
//  frame
//
//  Created by Catie Rencricca on 11/28/18.
//  Copyright © 2018 Catie Rencricca. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var moodCollectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    var moodArray: [Option]!
    var moodViewLabel: UILabel!
    
    let customFont = UIFont(name: "CircularStd-Bold", size: 40)
    let customFontText = UIFont(name: "CircularStd-Bold", size: 30)
    
    var moodSelected: UICollectionViewCell?
    let moodCellReuseIdentifier = "moodCellReuseIdentifier"
    let backgroundColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
    let padding: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        
        let chill = Option(option: "Calm")
        let hype = Option(option: "Excited")
        let happy = Option(option: "Happy")
        let sad = Option(option: "Sad")
        moodArray = [chill, hype, happy, sad]
        
        moodViewLabel = UILabel()
        moodViewLabel.translatesAutoresizingMaskIntoConstraints = false
        moodViewLabel.adjustsFontForContentSizeCategory = true
        moodViewLabel.text = "Select A Mood"
        moodViewLabel.font = customFont
        moodViewLabel.numberOfLines = 2
        moodViewLabel.textAlignment = .center
        moodViewLabel.textColor = .white
        view.addSubview(moodViewLabel)
        
        // Setup Collection View
        // UICollectionViewFlowLayout is used to help organize our cells/items into a grid-pattern
        let layout = UICollectionViewFlowLayout()
        // scrollDirection can be vertical or horizontal
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        moodCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        moodCollectionView.translatesAutoresizingMaskIntoConstraints = false
        moodCollectionView.backgroundColor = backgroundColor
        moodCollectionView.dataSource = self
        moodCollectionView.alwaysBounceVertical = true
        moodCollectionView.delegate = self
        //making sure we refresh the page
        moodCollectionView.refreshControl = refreshControl
        moodCollectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: moodCellReuseIdentifier)
        
        let chooseActivityButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(chooseActivity))
        self.navigationItem.rightBarButtonItem = chooseActivityButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        view.addSubview(moodCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            moodViewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moodViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            moodCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            moodCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moodCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moodCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == moodCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moodCellReuseIdentifier, for: indexPath) as! MoodCollectionViewCell
            let mood = moodArray[indexPath.item]
            cell.configure(for: mood)
            cell.setNeedsUpdateConstraints()
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moodCellReuseIdentifier, for: indexPath) as! MoodCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == moodCollectionView{
            return moodArray.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = moodCollectionView.cellForItem(at: indexPath)
        let cellAsMCVC = moodCollectionView.cellForItem(at: indexPath) as! MoodCollectionViewCell
        ViewController.Data.mood = moodArray[indexPath.row].option
        if (moodSelected == cell) {
            cellAsMCVC.moodButton.backgroundColor = .clear
            moodSelected = nil
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            if(moodSelected != nil) {
                let moodSelectedCell = moodSelected as! MoodCollectionViewCell
                moodSelectedCell.moodButton.backgroundColor = .clear
            }
            cellAsMCVC.moodButton.backgroundColor = .black
            moodSelected = cell!
            self.navigationItem.rightBarButtonItem?.isEnabled = true

        }
    }
    
    @objc func chooseActivity() {
        let activityView = ActivityViewController()
        self.navigationController?.pushViewController(activityView, animated: true)
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == moodCollectionView {
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

