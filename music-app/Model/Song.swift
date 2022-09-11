//
//  Song.swift
//  music-app
//
//  Created by Olga Pavluchenko on 9.09.22.
//

import Foundation
import UIKit

struct Song: Hashable {
    var id: Int
    var name: String
    var songFile: String
    var artist: String
    var albumArt: String
}
