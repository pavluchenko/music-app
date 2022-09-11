//
//  MusicApp.swift
//  MusicApp
//
//  Created by Olga Pavluchenko on 9.09.22.
//

import SwiftUI

@main
struct MusicApp: App {
    var body: some Scene {
        WindowGroup {
            ListSongView()
                .environmentObject(MusicAppViewModel())
        }
    }
}
