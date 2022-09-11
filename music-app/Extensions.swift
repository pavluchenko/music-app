//
//  Extensions.swift
//  music-app
//
//  Created by Olga Pavluchenko on 10.09.22.
//

import Foundation
extension DateComponentsFormatter {
    static let positional: DateComponentsFormatter = {
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
}
