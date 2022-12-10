//
//  ProgressBarView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct ProgressBarView: View {
    var progress: CGFloat = 0.0
    var body: some View {
        Capsule()
            .foregroundColor(Color.progressBackgroundColor)
            .frame(width: 191, height: 8)
            .overlay(alignment: .leading) {
                Capsule()
                    .overlay(
                        LinearGradient(colors: [Color.startPointColor, Color.endPointColor],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
                    .cornerRadius(5)
                    .frame(width: 191 * progress, height: 8)
            }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
