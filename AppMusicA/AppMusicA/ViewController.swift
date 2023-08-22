import UIKit
import AVFoundation
final class ViewController: UIViewController {
    // obj
    @IBOutlet weak private var nameAudio: UILabel!
    @IBOutlet weak private var imageAudio: UIImageView!
    @IBOutlet weak private var performer: UILabel!
    @IBOutlet weak private var preBtn: UIButton!
    @IBOutlet weak private var playBtn: UIButton!
    @IBOutlet weak private var nextBtn: UIButton!
    @IBOutlet weak var playTimeCurrent: UISlider!
    // Value
    private var audioList: [Audio] = []
    private var possition: Int = 0
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
    }
}