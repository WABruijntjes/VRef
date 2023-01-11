//
//  TrainingScreen.swift
//  VRef_v1
//
//  Created by William on 31/10/2022.
//

import SwiftUI
import AVKit
import GameController

struct TrainingScreen: View, KeyboardReadable {
    
    @EnvironmentObject var trainingSessionVM: TrainingSessionViewModel
    
    @State private var isKeyboardVisible = false
    
    @State private var streamPlayerToSwitch: StreamPlayerToSwitch = .primary
    @State private var eventToChange: Event?
    
    @State private var navigateToTrainingOverview: Bool = false
    
    @State private var player1 = AVPlayer()
    @State private var player2 = AVPlayer()
    
    @State private var fullScreen1 = false
    @State private var fullScreen2 = false
    
    @State private var player1CurrentStreamIndex = 0
    @State private var player2CurrentStreamIndex = 1
    
    var videoStreams: [VideoStream] = [
        VideoStream(id: 0, videoURL: URL(string: "https://vrefstorageproduction.blob.core.windows.net/con/2/training-1/POV-1.mp4")!, videoThumbnail: "Thumbnail_Stream1"),
        VideoStream(id: 1, videoURL: URL(string: "https://vrefstorageproduction.blob.core.windows.net/con/2/training-1/POV-2.mp4")!, videoThumbnail: "Thumbnail_Stream2")
    ]
    
    var body: some View {
        ZStack{
            VStack(spacing: 5) {
                ZStack{
                    VideoPlayer(player: player1, fullScreen: $fullScreen1)
                        .frame(height: 400)
                        .onTapGesture(count: 2) {
                            if(player1CurrentStreamIndex + 1 < videoStreams.count){
                                self.player1CurrentStreamIndex += 1
                            }else{
                                self.player1CurrentStreamIndex = 0
                            }
                            player1.replaceCurrentItem(with: AVPlayerItem(url: videoStreams[player1CurrentStreamIndex].videoURL))
                        }
                        .onAppear{
                            player1.replaceCurrentItem(with: AVPlayerItem(url: videoStreams[player1CurrentStreamIndex].videoURL))
                        }
                        .fullScreenCover(isPresented: $fullScreen1) {
                            ZStack{
                                VideoPlayer(player: player1, fullScreen: $fullScreen1)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    
                                VStack{
                                    HStack{
                                        Spacer()
                                        FullScreen_Button(fullScreen: $fullScreen1, player: 1)
                                        
                                    }
                                    Spacer()
                                }
                            }
                        }
                    VStack{
                        HStack{
                            Spacer()
                            FullScreen_Button(fullScreen: $fullScreen1, player: 1)
                            
                        }
                        Spacer()
                    }
                }
                
                HStack {
                    ZStack{
                        VideoPlayer(player: player2, fullScreen: $fullScreen2)
                            .onTapGesture(count: 2) {
                                if(player2CurrentStreamIndex + 1 < videoStreams.count){
                                    self.player2CurrentStreamIndex += 1
                                }else{
                                    self.player2CurrentStreamIndex = 0
                                }
                                player2.replaceCurrentItem(with: AVPlayerItem(url: videoStreams[player2CurrentStreamIndex].videoURL))
                            }
                            .onAppear{
                                player2.replaceCurrentItem(with: AVPlayerItem(url: videoStreams[player2CurrentStreamIndex].videoURL))
                            }
                            .fullScreenCover(isPresented: $fullScreen2) {
                                ZStack{
                                    VideoPlayer(player: player2, fullScreen: $fullScreen2)
                                    VStack{
                                        HStack{
                                            Spacer()
                                            FullScreen_Button(fullScreen: $fullScreen2, player: 2)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        VStack{
                            HStack{
                                Spacer()
                                FullScreen_Button(fullScreen: $fullScreen2, player: 2)
                                
                            }
                            Spacer()
                        }
                    }
                    Training_EventList(eventToChange: $eventToChange)
                }
                .frame(maxWidth: .infinity)
                .clipped()
            }
            .onTapGesture {
                UIApplication.shared.closeKeyboard()
            }
            
            Action_Button(streamPlayerToSwitch: makeBinding())
            
            if(isKeyboardVisible && !trainingSessionVM.showingAddEventForm && !trainingSessionVM.showingChangeEventForm){
                ZStack(alignment: .leading){
                    if(trainingSessionVM.newEventMessage.isEmpty){
                        Text("Write some quick feedack...")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    TextField("", text: $trainingSessionVM.newEventMessage)
                        .foregroundColor(.black)
                        .autocapitalization(.sentences)
                        .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(10)
                    
                }
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                .offset(y: 90) //Can also be -55 or 0 sometimes. What this jump in offset is based on is unclear
            }
        }
        .sheet(isPresented: $trainingSessionVM.showingExitTrainingForm) {
            ExitTrainingScreen(navigateToTrainingOverview: $navigateToTrainingOverview)
        }
        .sheet(isPresented: $trainingSessionVM.showingAddEventForm) {
            AddEventScreen()
        }
        .sheet(isPresented: $trainingSessionVM.showingChangeEventForm){
            ChangeEventScreen(event: eventToChange!) //TODO: Remove ! and change for non optional
        }
        .sheet(isPresented: $trainingSessionVM.showingSwitchCameraForm) {
            switch streamPlayerToSwitch {
            case .primary:
                SwitchCameraScreen(videoStreams: videoStreams, player: $player1)
            case .secondary:
                SwitchCameraScreen(videoStreams: videoStreams, player: $player2)
            }
        }
        .navigationDestination(isPresented: $navigateToTrainingOverview) {
            TrainingOverview()
        }
        .ignoresSafeArea(.keyboard)
        .statusBar(hidden: isKeyboardVisible)
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
        .alert(isPresented: $trainingSessionVM.sessionAlert) {
            Alert(title: Text("Error"),
                  message: Text(trainingSessionVM.sessionErrorDescription),
                  dismissButton: .default(Text("Okay"))
            )
        }
        .toolbar(.hidden)
        
    }
    
    func makeBinding() -> Binding<StreamPlayerToSwitch> {
        return Binding(get: { return streamPlayerToSwitch },set: { switchValue in
            streamPlayerToSwitch = switchValue
        }
    ) }
}
