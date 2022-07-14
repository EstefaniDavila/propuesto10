//
//  ViewController.swift
//  propuesto10
//
//  Created by Mac 17 on 16/05/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var play: UIButton!
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer :AVAudioPlayer!
    
    
    var fileName: String = "audiofile.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            setupRecorder()
            play.isEnabled = false
            // Do any additional setup after loading the view.
    }
    func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
    
    func setupRecorder() {
            let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
            let recordSetting = [ AVFormatIDKey : kAudioFormatAppleLossless,
                                  AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                                  AVEncoderBitRateKey : 320000,
                                  AVNumberOfChannelsKey : 2,
                                  AVSampleRateKey : 44100.2] as [String : Any]
            
            do {
                soundRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting )
                soundRecorder.delegate = self
                soundRecorder.prepareToRecord()
            } catch {
                print(error)
            }
        }
    func setupPlayer() {
            let audioFilename = getDocumentsDirectory().appendingPathComponent(fileName)
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                soundPlayer.delegate = self
                soundPlayer.prepareToPlay()
                soundPlayer.volume = 1.0
            } catch {
                print(error)
            }
        }
        
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
            play.isEnabled = true
        }
        
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            record.isEnabled = true
            play.setTitle("Play", for: .normal)
        }
    


    @IBAction func play(_ sender: Any) {
        if record.titleLabel?.text == "Record" {
                    soundRecorder.record()
                    record.setTitle("Stop", for: .normal)
                    play.isEnabled = false
                } else {
                    soundRecorder.stop()
                    record.setTitle("Record", for: .normal)
                    play.isEnabled = false
                }
            }
    
    
    @IBAction func stopTapped(_ sender: Any) {
        if play.titleLabel?.text == "Play" {
                    play.setTitle("Stop", for: .normal)
                    record.isEnabled = false
                    setupPlayer()
                    soundPlayer.play()
                } else {
                    soundPlayer.stop()
                    play.setTitle("Play", for: .normal)
                    record.isEnabled = false
                }
            }
}

