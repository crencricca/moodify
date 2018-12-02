//
//  PlaylistViewController.swift
//  frame
//
//  Created by Catie Rencricca on 11/28/18.
//  Copyright © 2018 Catie Rencricca. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    var playlistScreenLabel: UILabel!
    var startButton: UIButton!
    var playlistImageView: UIImageView!
    var playlistName: UILabel!
    var openSpotify: UIButton!
    
    let customFont = UIFont(name: "CircularStd-Bold", size: 25)
    let customFontText = UIFont(name: "CircularStd-Bold", size: 30)
    let mood = ViewController.Data.mood!
    let activity = ViewController.Data.activity
    let genre = ViewController.Data.genre
    
    let backgroundColor = UIColor(red:0.25, green:0.25, blue:0.25, alpha:1.0)
    let padding: CGFloat = 8
    var playlist:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Here's Your Playlist"
        view.backgroundColor = backgroundColor
        
        playlistName = UILabel()
        playlistName.translatesAutoresizingMaskIntoConstraints = false
        playlistName.font = customFont
        playlistName.text = "We Found A Playlist For You..."
        playlistName.textColor = .white
        view.addSubview(playlistName)
        
        playlistImageView = UIImageView(frame: .zero)
        playlistImageView.translatesAutoresizingMaskIntoConstraints = false
        //playlistImageView.contentMode = .scaleAspectFit
        playlistImageView.image = UIImage(named: "placeholder")
        view.addSubview(playlistImageView)
        
        startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start Over", for: .normal)
        startButton.backgroundColor = .gray
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 5
        startButton.clipsToBounds = true
        startButton.titleLabel?.font = customFontText
        startButton.addTarget(self, action: #selector(startOver), for: .touchUpInside)
        view.addSubview(startButton)
        
        retrievePlaylist()
        
        openSpotify = UIButton()
        openSpotify.translatesAutoresizingMaskIntoConstraints = false
        openSpotify.setTitle("Open in Spotify", for: .normal)
        openSpotify.backgroundColor = .green
        openSpotify.setTitleColor(.white, for: .normal)
        openSpotify.layer.cornerRadius = 5
        openSpotify.clipsToBounds = true
        openSpotify.titleLabel?.font = customFontText
        openSpotify.addTarget(self, action: #selector(openInSpotify), for: .touchUpInside)
        openSpotify.isEnabled = false
        view.addSubview(openSpotify)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            playlistName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playlistName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            playlistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playlistImageView.topAnchor.constraint(equalTo: playlistName.bottomAnchor, constant: 50),
            playlistImageView.heightAnchor.constraint(equalToConstant: 300),
            playlistImageView.widthAnchor.constraint(equalToConstant: 300),
            
            openSpotify.heightAnchor.constraint(equalToConstant: 60),
            openSpotify.widthAnchor.constraint(equalToConstant:300),
            openSpotify.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openSpotify.topAnchor.constraint(equalTo: playlistImageView.bottomAnchor, constant: 20),
            
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 220),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            ])
    }
    
    @objc func startOver() {
        self.dismiss(animated: true)
    }
    
    func retrievePlaylist() {
        NetworkManager.getPlaylist() { (playlist) in
            self.playlist = playlist
            self.openSpotify.isEnabled = true
        }
        
    }
    
    @objc func openInSpotify() {
        
        let url = playlist.replacingOccurrences(of: "\"", with: "")
        let p = URL(string: url)
        if let link = p {
            UIApplication.shared.open(link, options: [:])
        }
        
    }

        
//        if
//            let p = URL(string: playlist),
//            UIApplication.shared.canOpenURL(p)
//        {
//            print(p)
//            UIApplication.shared.open(p, options: [:])
//        }
//        print(URL(string: playlist))
//        }

}


