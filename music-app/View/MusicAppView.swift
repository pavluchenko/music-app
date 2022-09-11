//
//  MusicAppView.swift
//  music-app
//
//  Created by Olga Pavluchenko on 10.09.22.
//


import SwiftUI
import AVFoundation

struct MusicAppView: View {
    @EnvironmentObject var musicManager: MusicAppViewModel
    
    @State var song: Song
    @State var currentSongIndex: Int
    
    @State private var currentTime = 0.0
    @State private var duration = 0.0
    @State private var value = 0.0
    @State private var isEditing = false
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            // MARK: - Background
            Color(red: 20/255, green: 0/255, blue: 79/255)
                .ignoresSafeArea(.all, edges: .all)
            
            Circle()
                .fill(Color(red: 147/255, green: 0/255, blue: 132/255))
                .frame(width: 300, height: 300)
                .position(x: 20, y: 370)
                .blur(radius: 100)
            
            VStack{
                // MARK: - Album Art
                Image(song.albumArt)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 281, height: 321)
                    .cornerRadius(48)
                
                // MARK: - Song Info
                VStack{
                    Text(song.name)
                        .font(Font.system(size: 16))
                        .bold()
                    Text(song.artist)
                        .font(Font.system(size: 14))
                }
                .padding(.top, 20)
                
                // MARK: - Slider and Song Time
                if let player = musicManager.audioPlayer{
                    VStack{
                        Slider(
                            value: $value,
                            in: 0...player.duration,
                            onEditingChanged: { editing in
                                
                                if !editing {
                                    player.currentTime = value
                                }
                                isEditing = editing
                            }
                        )
                        
                        HStack{
                            Text(DateComponentsFormatter.positional.string(from: currentTime)?.dropFirst() ?? "0:00")
                            Spacer()
                            Text(DateComponentsFormatter.positional.string(from: duration - currentTime)?.dropFirst() ?? "0:00")
                        }
                        .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255, opacity: 0.8))
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Controls
                    Spacer()
                    HStack(spacing: 15){
                        // MARK: -- Shuffle Songs
                        ButtonComponent(labelIcon: !musicManager.isShuffled ? "shuffle" : "shuffle.circle.fill", action: {
                            if !musicManager.isShuffled {
                                musicManager.shuffle()
                            }else{
                                musicManager.notShuffled()
                            }
                        }, size: 17)
                        
                        // MARK: -- Go backwards
                        ButtonComponent(labelIcon: "backward.end.fill", action: {
                            if currentSongIndex != 1  {
                                currentSongIndex -= 1
                                self.changeSongs()
                            }else if currentSongIndex == 1{
                                currentSongIndex = 5
                                self.changeSongs()
                            }
                        }, size: 30)
                        .padding(.leading)
                       
                        // MARK: -- Play songs
                        ButtonComponent(labelIcon: !player.isPlaying ? "play.circle.fill":"pause.circle.fill", action: {
                            if player.isPlaying {
                                musicManager.pause()
                            }else{
                                musicManager.play()
                            }
                        }, size: 90)
                    
                        // MARK: -- Go forwards
                        ButtonComponent(labelIcon: "forward.end.fill", action: {
                            if musicManager.songQueue.count != currentSongIndex  {
                                currentSongIndex += 1
                                self.changeSongs()
                            }else{
                                currentSongIndex = 1
                                self.changeSongs()
                            }
                        }, size: 30)
                        .padding(.trailing)
                        
                        // MARK: -- Repeat songs
                        ButtonComponent(labelIcon: player.numberOfLoops == 0 ? "repeat": "repeat.1", action: {
                            if player.numberOfLoops == 0{
                                musicManager.repeatSong(iter: -1)
                            }else {
                                musicManager.repeatSong(iter: 0)
                            }
                        }, size: 17)
                        
                    }
                    Spacer()
                }
            }
            .onReceive(timer) { _ in
                guard let player = musicManager.audioPlayer, !isEditing else { return }
                
                // set current time and duration to time interval
                duration = player.duration
                currentTime = player.currentTime
                value = player.currentTime
            }
            .onAppear {
                // get the url song path
                let soundFile = Bundle.main.path(forResource: song.songFile, ofType: nil)
                
                // set the audio player when view appears
                musicManager.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundFile!))
            }
            
        }
        .foregroundColor(.white)

    }
    
    func changeSongs(){
        
        let url = Bundle.main.path(forResource: musicManager.songQueue[currentSongIndex - 1], ofType: nil )
        musicManager.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))

        // get next apporiate song object by currentIndex
        let nextSong = musicManager.mySongs.first { song in
            musicManager.songQueue[currentSongIndex - 1] == song.songFile
        }

        // set the current song to next song for UI update
        song = nextSong ?? Song(id: 1, name: "", songFile: "", artist: "", albumArt: "")

        musicManager.audioPlayer.play()

    }
}

