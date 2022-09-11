//
//  RecommendedSongView.swift
//  music-app
//
//  Created by Olga Pavluchenko on 10.09.22.
//


import SwiftUI

struct RecommendedSongView: View {
    var song: Song
    var body: some View {
        HStack(spacing: 15){
            Image(song.albumArt)
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 75)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(song.name)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text(song.artist)
                    .fontWeight(.light)
                    .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.6))
            }
            Spacer()
        }
    }
}
