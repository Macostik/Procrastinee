//
//  RemindersView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI
import AVFoundation

struct RemindersView: View {
    @Environment(\.dependency) private var dependency
    var onNextScreen: (() -> Void)?
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Planning Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    var body: some View {
        VStack {
            Text(L10n.Onboarding.keepYourTrack)
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            Text(L10n.Onboarding.useReminders)
                .font(.system(size: 18).weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.grayColor)
                .padding(.horizontal, 90)
                .padding(.top, -10)
            Spacer()
            Image.reminders
                .resizable()
                .frame(width: 348, height: 217)
                .scaledToFit()
                .offset(y: -40)
            Spacer()
            GradientButton(action: {
                UIImpactFeedbackGenerator(style: .soft)
                    .impactOccurred()
                player?.play()
                dependency.provider.notificationService
                    .requestNotificationPermission {
                        onNextScreen?()
                    }
            }, label: {
                HStack {
                    Image.checkmark
                    Text(L10n.Onboarding.yesPlease)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                }
            })
            .padding(.horizontal, 23)
            .padding(.bottom, 36)
        }
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}
