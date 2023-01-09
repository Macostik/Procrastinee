//
//  SoundView.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import SwiftUI

struct SoundView: View {
    var sound: Sound
    var selected: Bool
    var body: some View {
        VStack(spacing: 16) {
            Image(sound.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 62, height: 62)
                .clipShape(Circle())
                .background(
                    Circle()
                        .strokeBorder(gradientVertical, lineWidth: selected ? 2 : 0)
                        .frame(width: 70, height: 70)
                )
            Text(sound.rawValue.capitalized)
                .font(.system(size: 14).weight(.medium))
                .foregroundColor(Color.settingsTextColor)
        }
    }
}
