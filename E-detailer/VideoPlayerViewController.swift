//
//  VideoPlayerViewController.swift
//  E-detailer
//
//  Created by Ammad on 8/28/18.
//  Copyright © 2018 Ammad. All rights reserved.
//

import Foundation
import UIKit
import Player
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController, PlayerPlaybackDelegate  {
    func playerPlaybackDidLoop(_ player: Player) {
        
    }
    
    
    var videoModel: VideoContentResult? = nil
    var player: AVPlayer? = nil
    @IBOutlet weak var onBack: UIButton!
    
    override func viewDidLoad() {
        
        self.play()
        //        let videoUrl = URL.init(string: (videoModel?.video_file_url)!)
        //        self.player = AVPlayer(url: videoUrl!)
        //        let playerViewController = AVPlayerViewController()
        //        playerViewController.player = player
        //        self.present(playerViewController, animated: true) {
        //            playerViewController.player!.play()
        //        }
    }
    
    func play()
    {
        let videoUrl = URL.init(string: (videoModel?.video_file_url)!)
        let player = AVPlayer(url: videoUrl!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true)
        {
            playerViewController.player!.play()
        }
        
        
    }
    
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        print("video started")
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        print("video ended")
    }
    
    func playerCurrentTimeDidChange(_ player: Player) {
        print("video time changed")
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        print("video time loop")
    }
    
    
    @IBAction func onBackClick(_ sender: Any) {
        onBack.layer.cornerRadius = 10
        onBack.clipsToBounds = true
        self.dismiss(animated: true, completion: nil)
        
    }
}
