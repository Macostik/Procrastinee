//
//  ProgressBarView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct ProgressBarView: View {
    @State private var progress: CGFloat = 0.0
    var completion: () -> Void
    var body: some View {
        Capsule()
            .foregroundColor(Color.progressBackgroundColor)
            .frame(width: 191, height: 8)
            .overlay(alignment: .leading) {
                Capsule()
                    .overlay(gradient)
                    .cornerRadius(5)
                    .frame(width: 191 * progress, height: 8)
            }
            .onAnimationCompleted(for: progress,
                                  completion: completion)
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0)) {
                    progress = 1.0
                }
            }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView {}
    }
}
