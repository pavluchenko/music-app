//
//  MusicAppViewModel.swift
//  music-app
//
//  Created by Olga Pavluchenko on 10.09.22.
//

import Foundation
import AVFAudio
import AVFoundation

class MusicAppViewModel: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer!
    @Published var isShuffled: Bool! = false
    
    init(){
    }
    @Published var songQueue: [String] = ["Das Ich - Kannibale.mp3", "Marilyn Manson - The Nobodies.mp3", "Rammstein - DEUTSCHLAND.mp3"]
    
    var mySongs = [
        Song(id: 1, name: "Kannibale", songFile: "Das Ich - Kannibale.mp3", artist: "Das Ich", albumArt: "kannibale"),
        Song(id: 2, name: "The Nobodies", songFile: "Marilyn Manson - The Nobodies.mp3", artist: "Marilyn Manson",albumArt: "nobodies"),
        Song(id: 3, name: "DEUTSCHLAND", songFile: "Rammstein - DEUTSCHLAND.mp3", artist: "Rammstein", albumArt: "deutschland"),
    ]
    
    func play() {
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.play()
    }
    func pause() {
        self.audioPlayer?.pause()
    }
    
    func repeatSong(iter: Int) {
        self.audioPlayer.numberOfLoops = iter
    }
    func shuffle() {
        self.isShuffled = true
        let shuffle = self.songQueue.shuffled()
        self.songQueue = shuffle
    }
    func notShuffled() {
        self.isShuffled = false
        self.songQueue = ["Rammstein - DEUTSCHLAND.mp3", "Marilyn Manson - The Nobodies.mp3", "Das Ich - Kannibale.mp3"]
    }
}

