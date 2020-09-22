//
//  ProgramDetailViewController.swift
//  SchoolFestivalNavi
//
//  Created by 西田翔平 on 2019/12/10.
//  Copyright © 2019 Shohei Nishida. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ProgramDetailViewController: UIViewController {
    
    @IBOutlet weak var programTitleLabel: UILabel!
    @IBOutlet weak var programImageView: UIImageView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var thumbnailContentView: UIView!
    
    var data: (title: String, content: String, imageURL: String, videoURL: String, id: String)!
    var stageData: (title: String, content: String, time: String, imageURL: String, videoURL: String, id: String)!
    
    var url = URL(string: "https://firebasestorage.googleapis.com/v0/b/orangefesapp.appspot.com/o/prom.mp4?alt=media&token=5e0c3959-33bb-427e-b855-c0dd58bdc528")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUIDesign()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if stageData != nil {
            guard stageData.videoURL != "" else { return }
            thumbnailContentView.isHidden = false
            scrollViewHeight.constant = 1100
            thumbnail.image = thumnailImageForFileUrl(fileUrl: URL(string: stageData.videoURL)!)
            url = URL(string: stageData.videoURL)!
        }
        if data != nil {
            guard data.videoURL != "" else { return }
            thumbnailContentView.isHidden = false
            scrollViewHeight.constant = 1100
            thumbnail.image = thumnailImageForFileUrl(fileUrl: URL(string: data.videoURL)!)
            url = URL(string: data.videoURL)!
        }
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickThumbnail(_ sender: Any) {
        loadVideo()
    }
    
    
    func loadData() {
        if data != nil {
            programTitleLabel.text = data.title
            descriptionTextView.text = data.content
            programImageView.loadImageAsynchronously(url: data.imageURL)
        }
        if stageData != nil {
            programTitleLabel.text = stageData.title
            descriptionTextView.text = stageData.content
            programImageView.loadImageAsynchronously(url: stageData.imageURL)
        }
    }
    
    func loadVideo() {
        let player = AVPlayer(url: url!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func thumnailImageForFileUrl(fileUrl: URL) -> UIImage? {
        let asset = AVAsset(url: fileUrl)

        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1,timescale: 60), actualTime: nil)
            print("サムネイルの切り取り成功！")
            return UIImage(cgImage: thumnailCGImage, scale: 0, orientation: .up)
        }catch let err{
            print("エラー\(err)")
        }
        return nil
    }
    
    
    func loadUIDesign() {
        thumbnailContentView.isHidden = true
        scrollViewHeight.constant = 800

        programImageView.contentMode = .scaleAspectFill
        programImageView.layer.masksToBounds = true
        programImageView.layer.cornerRadius = 15
        
        thumbnail.layer.cornerRadius = 15
        thumbnail.contentMode = .scaleAspectFill
    }
}

