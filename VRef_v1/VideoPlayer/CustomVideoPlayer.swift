//
//  AVPlayerControllerRepresented.swift
//  VRef_v1
//
//  Created by William on 05/11/2022.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer : UIViewControllerRepresentable {
    var player : AVPlayer
    var fullScreen : Bool

    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()

        controller.player = player
        controller.showsPlaybackControls = false
        controller.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        controller.videoGravity = .resizeAspectFill
        player.play()
        loopVideo(player: player)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
    
    func loopVideo(player p: AVPlayer) {
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: p.currentItem, queue: nil) { notification in
                p.seek(to: .zero)
                p.play()
            }
        }
}
