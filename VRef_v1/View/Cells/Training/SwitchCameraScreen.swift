//
//  SwitchCameraScreen.swift
//  VRef_v1
//
//  Created by William on 30/12/2022.
//

import SwiftUI
import AVKit

struct SwitchCameraScreen: View {
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    var videoStreams: [VideoStream]
    
    @Binding var player: AVPlayer

    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            VStack(spacing: 0) {
                HStack {
                    Text("Switch Camera")
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .font(.largeTitle)
                        .onTapGesture {
                            trainingSessionVM.showingSwitchCameraForm = false
                        }
                }
                .padding()
            }
            Text("Select stream")
                .font(.body.weight(.medium))
                .foregroundColor(Color(.sRGB, red: 132/255, green: 132/255, blue: 132/255))
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(videoStreams) { stream in
                        Image(stream.videoThumbnail)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .clipped()
                            .cornerRadius(10)
                            .onTapGesture {
                                player.replaceCurrentItem(with: AVPlayerItem(url: stream.videoURL))
                                trainingSessionVM.showingSwitchCameraForm = false
                            }
                    }
                }
                Spacer()
            }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color(.sRGB, red: 33/255, green: 33/255, blue: 33/255))
            }
            .frame(maxHeight: .infinity)
        }.padding(.horizontal)
    }
}
