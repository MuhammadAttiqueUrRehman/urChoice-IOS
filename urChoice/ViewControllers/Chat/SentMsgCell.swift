//
//  SentMsgCell.swift
//  kjkii
//
//  Created by Shahbaz on 05/10/2020.
//  Copyright © 2020 abbas. All rights reserved.
//

import UIKit

import AVKit


class SentMsgCell: UITableViewCell {
    
    @IBOutlet weak var msgBodyWidthCons: NSLayoutConstraint!
    @IBOutlet weak var cornerViWidthCons: NSLayoutConstraint!
    @IBOutlet weak var cornerViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var playAudioImage: UIImageView!
    @IBOutlet var textMsgContraints: [NSLayoutConstraint]!
    @IBOutlet weak var auidoView    : UIView!
    @IBOutlet weak var audiomsgHeight: NSLayoutConstraint!
    @IBOutlet var heightsToZero     : [NSLayoutConstraint]!
    @IBOutlet var lblsToClear       : [APLabel]!
    @IBOutlet var viewToHide        : [UIView]!
    
    @IBOutlet weak var variableCornerVu: VariableCornerRadiusView!
    @IBOutlet weak var userImage    : UIImageView!
    @IBOutlet weak var msgImg       : UIImageView!
    @IBOutlet weak var userName     : APLabel!
    @IBOutlet weak var msgBody      : APLabel!
    @IBOutlet weak var timeLabel    : APLabel!
    @IBOutlet weak var imgHeight    : NSLayoutConstraint!
    @IBOutlet weak var cellBackView : UIView!
    @IBOutlet weak var labelOverallDuration: UILabel!
    @IBOutlet weak var labelCurrentTime: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!
    @IBOutlet weak var ButtonPlay: UIButton!
    fileprivate let seekDuration: Float64 = 10
    var row                         = Int()
    var delegate                    : SelectedMsgDelegage?
    var audioMsgUrl                 : String?
    var isPlayingAudio              = false
    var player                      : AVPlayer?
    var progressTimer:Timer?
    {
        willSet {
            progressTimer?.invalidate()
        }
    }
    var playerItem: AVPlayerItem?
    var playerStream: AVPlayer?
   
//    let image = UIImage(named: "playicon")
//    var videoimageView = UIImageView()
    
    @IBOutlet weak var videoimageView: UIImageView!
    
    
    func configCell(item: Chats, row: Int){
//        UIHelper.shared.setImage(address: CurrentUser.userData()!.profile_pic ?? "", imgView: userImage)
        if let bgImage = UserDefaults.standard.imageForKey(key: "imageDefaults"){
        userImage.image = bgImage
        }
        self.row = row
        let long = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        self.addGestureRecognizer(long)
        videoimageView.isHidden = true
       
        timeLabel.textColor = UIColor().colorForHax("#D09715")
        if item.messageType == "text"{
            videoimageView.isHidden = true
          
            textMsgContraints.forEach({$0.priority = UILayoutPriority(rawValue: 999)})
            
            auidoView.isHidden = true
            imgHeight.priority  = UILayoutPriority(rawValue: 200)
            audiomsgHeight.priority = UILayoutPriority(rawValue: 200)
            msgBody.text        = item.user_message
           
            msgImg.image        = nil
            imgHeight.constant  = 0.0
            msgImg.isHidden     = true
            msgBody.isHidden    = false
            timeLabel.text = "12 min"
//            cornerViewLeadingConstraint.priority = UILayoutPriority(rawValue: 200)
//            cornerViWidthCons.priority = UILayoutPriority(rawValue: 999)
            
            if let font = UIFont(name: "System", size: 17) {
                let fontAttributes = [NSAttributedString.Key.font: font]
               let text = item.user_message
                let size = (text as! NSString).size(withAttributes: fontAttributes)
//                cornerViWidthCons.constant = (size.width + 30)
//                msgBodyWidthCons.constant = (size.width + 20)
                
            }
        }
        else if item.messageType == "video"
                    
        {
            videoimageView.isHidden = false
//            cornerViewLeadingConstraint.priority = UILayoutPriority(rawValue: 999)
//            cornerViWidthCons.priority = UILayoutPriority(rawValue: 200)
//
            textMsgContraints.forEach({$0.priority = UILayoutPriority(rawValue: 200)})
            auidoView.isHidden = true
            imgHeight.priority  = UILayoutPriority(rawValue: 999)
            msgBody.isHidden    = true
            msgBody.text        = nil
            getThumbnailImageFromVideoUrl(url: URL(string: item.files![0].full_url!)!) { [weak self](img) in
                guard let self = self else {return}
                self.msgImg.image = img
            }
            imgHeight.constant  = 200
            audiomsgHeight.priority = UILayoutPriority(rawValue: 200)
            msgImg.isHidden     = false
            timeLabel.text = "12 min"
        }
        else if item.messageType == "image"
        {
           
//            cornerViewLeadingConstraint.priority = UILayoutPriority(rawValue: 999)
//            cornerViWidthCons.priority = UILayoutPriority(rawValue: 200)
            videoimageView.isHidden = true
            textMsgContraints.forEach({$0.priority = UILayoutPriority(rawValue: 200)})
            auidoView.isHidden = true
            imgHeight.priority  = UILayoutPriority(rawValue: 999)
            msgBody.isHidden    = true
            msgBody.text        = nil
            UIHelper.shared.setImage(address: item.files![0].full_url!, imgView: msgImg)
            imgHeight.constant  = 200
            audiomsgHeight.priority = UILayoutPriority(rawValue: 200)
            msgImg.isHidden     = false
            timeLabel.text = "12 min"
        } else if item.messageType == "audio"{
//            cornerViewLeadingConstraint.priority = UILayoutPriority(rawValue: 999)
//            cornerViWidthCons.priority = UILayoutPriority(rawValue: 200)
            videoimageView.isHidden = true
           
            textMsgContraints.forEach({$0.priority = UILayoutPriority(rawValue: 200)})
            auidoView.isHidden = false
            audioMsgUrl = item.files![0].full_url
            let time = (Double(200) ?? 0.0) / 1000
            labelOverallDuration.text = stringFromTimeInterval(interval: time)
          
            audiomsgHeight.priority = UILayoutPriority(rawValue: 999)
            timeLabel.text = "12 min"
        }
        let name = defaults.string(forKey: "userName")
        userName.textColor = UIColor.white
        userName.text = name
       
        let time            = Date()
//        timeLabel.text      = timeIntervalWithDate(dateWithTime: time)
        UIHelper.shared.setCell(cell: self)
//        if item.isSelected{
//            cellBackView.backgroundColor = UIColor(named: "selectedMsg")
//        } else{
//            cellBackView.backgroundColor = .clear
//        }
        
    }
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer){
        if sender.state == .began{
            delegate?.selectedMsgs(row: row)
        }
    }
    
    @IBAction func playAudioBtnPressed(_ sender: Any) {
        if let _ = audioMsgUrl{
            if !isPlayingAudio{
                initAudioPlayer()
                player!.play()
                playAudioImage.image = UIImage(named: "pauseicon")
            }
            else{
                player?.pause()
                playAudioImage.image = UIImage(named: "playicon")
            }
            isPlayingAudio = !isPlayingAudio
        }
    }
    
    
    
    func initAudioPlayer(){
        let url = URL(string: audioMsgUrl ?? "")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player!.volume = 1.0
        playbackSlider.minimumValue = 0
        
        //To get overAll duration of the audio
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        labelOverallDuration.text = self.stringFromTimeInterval(interval: seconds)
       
        //To get the current duration of the audio
        let currentDuration : CMTime = playerItem.currentTime()
        let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
        labelCurrentTime.text = self.stringFromTimeInterval(interval: currentSeconds)
        
        
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        
        
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.playbackSlider.value = Float ( time );
                self.labelCurrentTime.text = self.stringFromTimeInterval(interval: time)
               
            }
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")
                self.ButtonPlay.isHidden = true
                //        self.loadingView.isHidden = false
            } else {
                //stop the activity indicator
                print("Buffering completed")
                self.ButtonPlay.isHidden = false
                //        self.loadingView.isHidden = true
            }
        }
       
       //change the progress value
        playbackSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        
        //check player has completed playing audio
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)}


    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player!.seek(to: targetTime)
        if player!.rate == 0 {
            player?.play()
        }
    }

    @objc func finishedPlaying( _ myNotification:NSNotification) {
        ButtonPlay.setImage(UIImage(named: "playicon"), for: UIControl.State.normal)
        playAudioImage.image = UIImage(named: "playicon")
        //reset player when finish
        playbackSlider.value = 0
        let targetTime:CMTime = CMTimeMake(value: 0, timescale: 1)
        player!.seek(to: targetTime)
    }

    @IBAction func playButton(_ sender: Any) {
        print("play Button")
//        if player?.rate == 0
//        {
//            if !isPlayingAudio{
//                player!.play()
//                self.ButtonPlay.isHidden = true
//            }
//            else{
//                player!.pause()
//                self.ButtonPlay.isHidden = false
//            }
//
//            //        self.loadingView.isHidden = false
//            //ButtonPlay.setImage(UIImage(systemName: "pause"), for: UIControl.State.normal)
//        } else {
//            player!.pause()
//            //ButtonPlay.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)
//        }
        
    }


    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }



    @IBAction func seekBackWards(_ sender: Any) {
        if player == nil { return }
        let playerCurrenTime = CMTimeGetSeconds(player!.currentTime())
        var newTime = playerCurrenTime - seekDuration
        if newTime < 0 { newTime = 0 }
        player?.pause()
        let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player?.seek(to: selectedTime)
        player?.play()

    }


    @IBAction func seekForward(_ sender: Any) {
        if player == nil { return }
        if let duration = player!.currentItem?.duration {
           let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
           let newTime = playerCurrentTime + seekDuration
           if newTime < CMTimeGetSeconds(duration)
           {
              let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as
           Float64), timescale: 1000)
              player!.seek(to: selectedTime)
           }
           player?.pause()
           player?.play()
          }
    }
    
    
    
    
}

struct FireBaseMessage{
    var deviceType      : String
    var message         : String
    var messageBy       : String
    var recordingTime   : String
    var seen            : String
    var time            : String
    
    var userId          : String
    var isSelected      : Bool
    var messageId       : String
    var id : Int?
    var message_id : Int
    var sender_id : Int
    var receiver_belong_to_model : String
    var receiver_belong_to_model_id : Int
    var type : String
    var seen_status : String
    var deliver_status : String
    var created_at : String
    var updated_at : String
    var files : [String]
    var user_message : String
    var user_receive : String
}
