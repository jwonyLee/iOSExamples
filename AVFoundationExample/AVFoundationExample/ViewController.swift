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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        requestMicrophoneAccess { allowed in
            if allowed {
                // 녹음 권한 허용
            } else {
                // 녹음 권한 거부
            }
        }
    }
}

// MARK: - Private Method
extension ViewController {
    /// 마이크 접근 권한 요청
    private func requestMicrophoneAccess(completion: @escaping (Bool) -> Void) {
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
    }
}
