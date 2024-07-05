//
//  ViewController.swift
//  MediaPlayer-UIKit
//
//  Created by 정종원 on 7/5/24.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    var mediaFiles: [MediaModel] = []
    var player: AVPlayer?
    var audioPlayer: AVAudioPlayer?
    
    //MARK: - UIComponents
    private lazy var mediaTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MediaCell.self, forCellReuseIdentifier: "MediaCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        
        view.addSubview(mediaTableView)
        
        NSLayoutConstraint.activate([
            mediaTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mediaTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mediaTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mediaTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        loadMediaFiles()
    }
    
    
    //MARK: - Methods
    func loadMediaFiles() {
        if let sampleURL = Bundle.main.url(forResource: "sample", withExtension: "mp3"),
           let sample2URL = Bundle.main.url(forResource: "sample2", withExtension: "mp3"),
           let saturnURL = Bundle.main.url(forResource: "SaturnV", withExtension: "mov") {
            mediaFiles.append(MediaModel(title: "Sample Audio 1", url: sampleURL))
            mediaFiles.append(MediaModel(title: "Sample Audio 2", url: sample2URL))
            mediaFiles.append(MediaModel(title: "Saturn Video", url: saturnURL))
            print(mediaFiles)
        }
        
        mediaTableView.reloadData()
    }
    
    func playVideo(_ url: URL) {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: url)
        present(playerViewController, animated: true) {
            self.player?.play()
        }
    }
}

//MARK: - UITableViewDelegate Methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaFile = mediaFiles[indexPath.row]
        playVideo(mediaFile.url)
    }
}

//MARK: - UITableViewDataSource Methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mediaFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as? MediaCell else { return UITableViewCell() }
        cell.mediaTextLabel.text = mediaFiles[indexPath.row].title
        cell.mediaTextLabel.textColor = .black
        return cell
    }
}

#Preview {
    ViewController()
}
