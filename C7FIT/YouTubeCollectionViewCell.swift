import UIKit
import youtube_ios_player_helper

protocol YouTubePlayerProtocol {
    var videoID: String? { get set }
    func play()
    func pause()
}

class YouTubeCollectionViewCell: UICollectionViewCell {

    fileprivate let youTubePlayerView: YTPlayerView
    fileprivate var _videoID: String? {
        didSet {
            if let _videoID = videoID {
                youTubePlayerView.load(withVideoId: _videoID)
            }
        }
    }

    override init(frame: CGRect) {
        youTubePlayerView = YTPlayerView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: frame.width,
                                                       height: frame.height))
        super.init(frame: frame)

        contentView.addSubview(youTubePlayerView)
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YouTubeCollectionViewCell: YouTubePlayerProtocol {

    var videoID: String? {
        get {
            return _videoID
        }
        set(newVideoID) {
            _videoID = newVideoID
        }
    }

    func play() {
        youTubePlayerView.playVideo()
    }

    func pause() {
        youTubePlayerView.pauseVideo()
    }
}
