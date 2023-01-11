//
//  VideoPlayer_1.swift
//  VRef_v1
//
//  Created by William on 29/12/2022.
//

import SwiftUI
import AVKit

struct VideoPlayer: View {
    
    var player: AVPlayer
    @Binding var fullScreen: Bool
    
    var body: some View {
        CustomVideoPlayer(player: player, fullScreen: fullScreen)
            .cornerRadius(10)
            .onAppear(){
                player.isMuted = true
            }
    }
}
