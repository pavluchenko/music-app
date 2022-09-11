//
//  ButtonComponent.swift
//  music-app
//
//  Created by Olga Pavluchenko on 10.09.22.
//

import SwiftUI

struct ButtonComponent: View {
    var labelIcon: String
    var action: () -> Void
    var size: CGFloat
    
    var body: some View {
        Button {
            action()
        } label: {
            if labelIcon == "shuffle" || labelIcon == "repeat"{
                Image(systemName: labelIcon)
                    .font(.system(size: size))
                    .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
            }else{
                Image(systemName: labelIcon)
                    .font(.system(size: size))
            }
        }
    }
}

struct ButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponent(labelIcon: "", action: {
            return
        }, size: 60)
    }
}

