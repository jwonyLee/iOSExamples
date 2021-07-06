//
//  ViewController.swift
//  AVFoundationExample
//
//  Created by 이지원 on 2021/06/26.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // MARK: - IBOutlet Properties
    @IBOutlet var recordButton: UIButton?
    @IBOutlet var stopButton: UIButton?
    @IBOutlet var playButton: UIButton?

    // MARK: - Properties
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private lazy var recordURL: URL = {
        var documentsURL: URL = {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths.first!
        }()

        let fileName = UUID().uuidString + ".m4a"
        let url = documentsURL.appendingPathComponent(fileName)
        return url
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        getListOfRecordingFiles()

        recordButton?.addTarget(self, action: #selector(record), for: .touchUpInside)
        stopButton?.addTarget(self, action: #selector(stop), for: .touchUpInside)
        playButton?.addTarget(self, action: #selector(play), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        requestMicrophoneAccess { [weak self] allowed in
            if allowed {
                // 녹음 권한 허용
                self?.configure()
            } else {
                // 녹음 권한 거부
            }
        }
    }
}

// MARK: - Private Method
extension ViewController {
    /// AVAudioRecorder 초기화
    private func configure() {
        let recorderSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        audioRecorder = try? AVAudioRecorder(url: recordURL, settings: recorderSettings)
        audioRecorder?.delegate = self
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
    }

    /// 앱 내에 저장된 녹음 파일 목록 출력
    private func getListOfRecordingFiles() {
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            print(directoryContents)

            // if you want to filter the directory contents you can do like this:
            let m4aFiles = directoryContents.filter{ $0.pathExtension == "m4a" }
            print("m4a urls:", m4aFiles)
            let m4aFileNames = m4aFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("m4a list:", m4aFileNames)

        } catch {
            print(error)
        }
    }

    /// 마이크 접근 권한 요청
    private func requestMicrophoneAccess(completion: @escaping (Bool) -> Void) {
        do {
            let recordingSession: AVAudioSession = AVAudioSession.sharedInstance()
            switch recordingSession.recordPermission {
            case .undetermined: // 아직 녹음 권한 요청이 되지 않음, 사용자에게 권한 요청
                recordingSession.requestRecordPermission({ allowed in
                    completion(allowed)
                })
            case .denied: // 사용자가 녹음 권한 거부, 사용자가 직접 설정 화면에서 권한 허용을 하게끔 유도
                print("[Failure] Record Permission is Denied.")
                let alertViewController = UIAlertController(title: "Michrophone Error!",
                                                            message: "Not Authorized to Access the Microphone!",
                                                            preferredStyle: .alert)

                alertViewController.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL,
                                                      options: [:],
                                                      completionHandler: nil)
                        }
                    }
                }))

                alertViewController.addAction(UIAlertAction(title: "Cancle", style: .cancel) { _ in
                    completion(false)
                })

                self.present(alertViewController, animated: true)
            case .granted: // 사용자가 녹음 권한 허용
                print("[Success] Record Permission is Granted.")
                completion(true)
            @unknown default:
                fatalError("[ERROR] Record Permission is Unknown Default.")
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    /// 녹음 시작
    @objc private func record() {
        requestMicrophoneAccess { [weak self] allowed in
            if allowed {
                guard let self = self else { return }
                if let recorder = self.audioRecorder {
                    let audioSession = AVAudioSession.sharedInstance()
                    guard !recorder.isRecording else {
                        print("이미 녹음 중")
                        return
                    }

                    do {
                        try audioSession.setActive(true)
                    } catch {
                        fatalError(error.localizedDescription)
                    }

                    recorder.record()
                    self.recordButtonToggle()
                }
            }
        }
    }

    /// 녹음 정지
    @objc private func stop() {
        if let recorder = self.audioRecorder {
            if recorder.isRecording {
                self.audioRecorder?.stop()
                self.recordButtonToggle()
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(false)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }

    // 재생
    @objc private func play() {
        if let recorder = audioRecorder {
            if !recorder.isRecording {
                let audioSession = AVAudioSession.sharedInstance()
                audioPlayer = try? AVAudioPlayer(contentsOf: recorder.url)
                audioPlayer?.volume = audioSession.outputVolume
                audioPlayer?.delegate = self
                audioPlayer?.play()
                recordButton?.isEnabled = false
                stopButton?.isEnabled = false
            }
        }
    }

    private func recordButtonToggle() {
        DispatchQueue.main.async {
            self.stopButton?.isEnabled.toggle()
            self.playButton?.isEnabled.toggle()
        }
    }
}

extension ViewController: AVAudioRecorderDelegate {
}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            recordButton?.isEnabled = true
        }
    }
}
