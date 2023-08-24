import UIKit

final class PlayListTableViewController: UIViewController {

    @IBOutlet private weak var playListTableView: UITableView!
    private var audioList: [Audio] = []
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initAudio()
        playListTableView.dataSource = self
        playListTableView.delegate = self
    }
    private func initAudio() {
        audioList.append(Audio(name: "LanCuoi",
                               title: "Lần Cuối",
                               performer: "Ngọt"))
        audioList.append(Audio(name: "KhacBietToLon",
                               title: "Khác Biệt To Lớn",
                               performer: "Liz Kim Cương ft Trịnh Thăng Bình"))
    }
}
extension PlayListTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListCell") as? PlayListCell {
            print(indexPath.row)
                cell.setInit(audio: audioList[indexPath.row])
                return cell
            }
            return UITableViewCell()
    }
    static let cellHeight: CGFloat = 105
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlayListTableViewController.cellHeight 
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let audioPlayView = storyboard?.instantiateViewController(
            withIdentifier: "AudioPlayView") as? ViewController {
            audioPlayView.audioList = audioList
            audioPlayView.possition = indexPath.row
            present(audioPlayView, animated: true)
        }
    }
}
