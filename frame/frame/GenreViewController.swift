//
//  GenreViewController.swift
//  frame
//
//  Created by Catie Rencricca on 11/27/18.
//  Copyright © 2018 Catie Rencricca. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GenreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var genreCollectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    var genreArray: [Option]!
    var genreViewLabel: UILabel!
    
    let customFont = UIFont(name: "CircularStd-Bold", size: 40)
    let customFontText = UIFont(name: "CircularStd-Bold", size: 30)
    
    var genreSelected: UICollectionViewCell?
    let backgroundColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
    let genreCellReuseIdentifier = "genreCellReuseIdentifier"
    let padding: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        
        let rock = Option(option: "Rock")
        let EDM = Option(option: "Electronic")
        let pop = Option(option: "Pop")
        let classical = Option(option: "Classical")

        genreArray = [rock, EDM, pop, classical]
        
        genreViewLabel = UILabel()
        genreViewLabel.translatesAutoresizingMaskIntoConstraints = false
        genreViewLabel.adjustsFontForContentSizeCategory = true
        genreViewLabel.text = "Select A Genre"
        genreViewLabel.font = customFont
        genreViewLabel.numberOfLines = 2
        genreViewLabel.textAlignment = .center
        genreViewLabel.textColor = .white
        view.addSubview(genreViewLabel)
        
        // Setup Collection View
        // UICollectionViewFlowLayout is used to help organize our cells/items into a grid-pattern
        let layout = UICollectionViewFlowLayout()
        // scrollDirection can be vertical or horizontal
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        genreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        genreCollectionView.backgroundColor = backgroundColor
        genreCollectionView.dataSource = self
        genreCollectionView.alwaysBounceVertical = true
        genreCollectionView.delegate = self
        //making sure we refresh the page
        genreCollectionView.refreshControl = refreshControl
        genreCollectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: genreCellReuseIdentifier)
        
        view.addSubview(genreCollectionView)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            genreViewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            genreViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            genreCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            genreCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genreCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            genreCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genreCellReuseIdentifier, for: indexPath) as! MoodCollectionViewCell
            let genre = genreArray[indexPath.item]
            cell.configure(for: genre)
            cell.setNeedsUpdateConstraints()
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genreCellReuseIdentifier, for: indexPath) as! MoodCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == genreCollectionView{
            return genreArray.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = genreCollectionView.cellForItem(at: indexPath)
        let cellAsMCVC = genreCollectionView.cellForItem(at: indexPath) as! MoodCollectionViewCell
        ViewController.Data.genre = genreArray[indexPath.row].option
        if (genreSelected == cell) {
            cellAsMCVC.moodButton.backgroundColor = .clear
            genreSelected = nil
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            if(genreSelected != nil) {
                let genreSelectedCell = genreSelected as! MoodCollectionViewCell
                genreSelectedCell.moodButton.backgroundColor = .clear
            }
            cellAsMCVC.moodButton.backgroundColor = .black
            genreSelected = cell!
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc func done() {
        let playlistViewController = PlaylistViewController()
        self.present(playlistViewController, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == genreCollectionView {
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
