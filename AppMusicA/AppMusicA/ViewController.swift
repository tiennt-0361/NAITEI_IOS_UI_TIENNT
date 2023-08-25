import UIKit
import AVFoundation
import MediaPlayer
final class ViewController: UIViewController {
    @IBOutlet weak private var nameAudio: UILabel!
    @IBOutlet weak private var imageAudio: UIImageView!
    @IBOutlet weak private var performer: UILabel!
    @IBOutlet weak private var preBtn: UIButton!
    @IBOutlet weak private var playBtn: UIButton!
    @IBOutlet weak private var nextBtn: UIButton!
    @IBOutlet weak private var playTimeCurrent: UISlider!
    var audioList: [Audio] = []
    var possition: Int = 0
    private var player = AVAudioPlayer()
    private var timeCurrent = Timer()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initAudio()
        loadOtherAudio()
        setupRemoteCommandControls()
    }
    private func initAudio() {
        audioList.append(Audio(name: "LanCuoi",
                               title: "Lần Cuối",
                               performer: "Ngọt"))
        audioList.append(Audio(name: "KhacBietToLon",
                               title: "Khác Biệt To Lớn",
                               performer: "Liz Kim Cương ft Trịnh Thăng Bình"))
    }
    private func playAudio(name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
                setupNowPlayingInfo()
            } catch {
                print("Error: Not Found Audio")
            }
        }
    }
    private func loadOtherAudio() {
        timeCurrent.invalidate()
        let currentAudio = audioList[possition]
        self.nameAudio.text = currentAudio.title
        self.performer.text = currentAudio.performer
        imageAudio.image = UIImage(named: currentAudio.name)
        timeCurrent = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {   [weak self] _ in
            if let self = self {
                let currentPlayTime = Float(self.player.currentTime)
                let audioDuration = Float(self.player.duration)
                if let slider = self.playTimeCurrent {
                    let calculatedValue = currentPlayTime/audioDuration
                    slider.value = calculatedValue
                }
            }
        }
        playAudio(name: currentAudio.name)
    }
    // Action
    @IBAction private func playBtnTouchUpInside(_ sender: Any) {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    @IBAction private func preBtnTouchUpInside(_ sender: Any) {
        if possition > 0 {
            possition -= 1
            loadOtherAudio()
        }
    }
    @IBAction private func nextBtnTouchUpInside(_ sender: Any) {
        if possition < audioList.count - 1 {
            possition += 1
            loadOtherAudio()
        }
    }
    @IBAction private func changePlayTime(_ sender: UISlider) {
        let audioDuration = player.duration
        let newPlayTime = audioDuration * Double(sender.value)
        player.currentTime = newPlayTime
        setupNowPlayingInfo()
    }
    private func setupRemoteCommandControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [unowned self] _ in
            player.play()
            return .success
        }
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [unowned self] _ in
            player.pause()
            return .success
        }
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { [unowned self] _ in
            if possition < audioList.count {
                possition += 1
                loadOtherAudio()
            }
            return .success
        }
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { [unowned self] _ in
            if possition > 0 {
                possition -= 1
                loadOtherAudio()
            }
            return .success
        }
    }
    func setupNowPlayingInfo() {
        let currentAudio = audioList[possition]
        let size = CGSize(width: 20, height: 20)
        if let artwork = UIImage(named: audioList[possition].name) {
            let mediaArtwork = MPMediaItemArtwork(boundsSize: size) { _ in
                return artwork
            }
            var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo
            nowPlayingInfo = [
                MPMediaItemPropertyTitle: currentAudio.title,
                MPMediaItemPropertyArtist: currentAudio.performer,
                MPMediaItemPropertyPlaybackDuration: player.duration,
                MPNowPlayingInfoPropertyElapsedPlaybackTime: player.currentTime,
                MPNowPlayingInfoPropertyPlaybackRate: player.rate,
                MPMediaItemPropertyArtwork: mediaArtwork
            ]
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            MPNowPlayingInfoCenter.default().playbackState = .playing
        }
    }
}
