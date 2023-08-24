//
//  PlayListCell.swift
//  AppMusicA
//
//  Created by Thanh Duong on 24/08/2023.
//

import UIKit

final class PlayListCell: UITableViewCell {

    @IBOutlet private weak var imagePlayList: UIImageView!
    @IBOutlet private weak var nameAudioPlayList: UILabel!
    @IBOutlet private weak var perfomerPlayList: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setInit(audio: Audio) {
        nameAudioPlayList.text = audio.title
        imagePlayList.image = UIImage(named: audio.name)
        perfomerPlayList.text = audio.performer
    }
}
