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
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7).delay(0.8)) {
                    progress = 0.4
                    withAnimation(.easeInOut(duration: 0.7).delay(0.3)) {
                        progress = 0.6
                        withAnimation(.easeInOut(duration: 2.0).delay(2.0)) {
                            progress = 1.0
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5,
                                              execute: {
                    completion()
                })
            }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView {}
    }
}
