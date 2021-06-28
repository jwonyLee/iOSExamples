# AVFoundationExample

- `getListOfRecordingFiles()`
  - 앱 내에 저장된 녹음 파일 목록 출력(Console)
- `requestMicrophoneAccess()`
  - 마이크 접근 권한 요청
- `configure()`
  - `audioRecorder` 초기화
- `record()`
  - 녹음 시작
- `stop()`
  - 녹음 정지
- `play()`
  - 녹음된 파일 재생
- `recordButtonToggle()`
  - `stopButton`, `playButton`의 `enabled` 상태를 토글

## 참고 자료

- [Swift Audio: Record, Store, and Play](https://medium.com/swift2go/swift-audio-record-store-and-play-af965bf92b26)
- [Learn how to play and record audio on iOS AVFoundation](https://blog.devgenius.io/ios-avfoundation-series-part-1-4eebaa837d9c)
- [AVAudioSession - Apple Developer Documentation](https://developer.apple.com/documentation/avfaudio/avaudiosession)
- [Getting list of files in documents folder - Stack Overflow](https://stackoverflow.com/questions/27721418/getting-list-of-files-in-documents-folder/27722526)