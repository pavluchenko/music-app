//
//  ListSongView.swift
//  music-app
//
//  Created by Olga Pavluchenko on 10.09.22.
//

import Foundation
import SwiftUI
import AVFAudio

struct ListSongView: View {
    
    @EnvironmentObject var musicModel: MusicAppViewModel
    var audioPlayer: AVAudioPlayer!
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .leading){
                
                // MARK: - Background
                Color(red: 20/255, green: 0/255, blue: 79/255)
                    .ignoresSafeArea(.all, edges: .all)
                
                Circle()
                    .fill(Color(red: 147/255, green: 0/255, blue: 132/255))
                    .frame(width: 300, height: 300)
                    .position(x: 20, y: 370)
                    .blur(radius: 100)
                
                // MARK: - Browse
                VStack(alignment: .leading) {
                        
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing: 15) {
                            ForEach(musicModel.mySongs, id: \.self) { song in
                                NavigationLink(destination: MusicAppView(song: song, currentSongIndex: song.id), label: {
                                    ListenSongView(song: song)
                                })
                            }
                        }
                        
                    }
                    .navigationTitle("Songs list")
                    .padding(.horizontal)
                    .frame(height:195)
                    
                    Text("Recommeded")
                        .bold()
                        .font(.title2)
                        .padding(.top)
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    // MARK: - Recommeded
                    ScrollView(showsIndicators: false){
                        LazyVStack(alignment: .leading, spacing: 15){
                            ForEach(musicModel.mySongs, id: \.self) { song in
                                NavigationLink {
                                    MusicAppView(song: song, currentSongIndex: song.id)
                                } label: {
                                    RecommendedSongView(song: song)
                                }

                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(height:350)
                    
                }
                .foregroundColor(.white)

            }

        }
        
        
    }
}
