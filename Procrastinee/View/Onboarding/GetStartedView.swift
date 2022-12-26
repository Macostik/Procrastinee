//
//  GetStartedView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI
import AVFoundation

struct GetStartedView: View {
    var onNextScreen: (() -> Void)?
    @State var player: AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "Tracker Tapbar Button",
                                  withExtension: "mp3")
        return try? AVAudioPlayer(contentsOf: url!,
                                  fileTypeHint: AVFileType.mp3.rawValue)
    }()
    var body: some View {
        ZStack {
            Image.getStarted
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 55)
                .offset(y: -9)
            VStack {
                Spacer()
                GradientButton(action: {
                    player?.play()
                    onNextScreen?()
                }, label: {
                    Text(L10n.Onboarding.getStarted)
                        .foregroundColor(Color.white)
                        .font(.system(size: 17)
                            .weight(.bold))
                })
            }
            .padding(.horizontal, 23)
            .padding(.bottom, 35)
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
