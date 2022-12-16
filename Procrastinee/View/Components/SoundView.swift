//
//  SoundView.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import SwiftUI

struct SoundView: View {
    var sound: Sound
    var body: some View {
        VStack(spacing: 16) {
            Circle()
                .foregroundColor(Color.grayColor)
                .frame(width: 62, height: 62)
            Text(sound.name)
                .font(.system(size: 14).weight(.medium))
                .foregroundColor(Color.settingsTextColor)
        }
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
