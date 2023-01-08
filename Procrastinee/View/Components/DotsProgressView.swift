//
//  DotsProgressView.swift
//  Procrastinee
//
//  Created by Macostik on 08.01.2023.
//

import SwiftUI

struct DotsProgressView: View {
    private (set) var dotsCount: Int
    @Binding var selectedIndex: Int
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...dotsCount, id: \.self) { index in
                Circle()
                    .frame(width: 2, height: 2)
                    .scaleEffect(selectedIndex >= index ? 3 : 1)
                    .padding(.trailing, index == 4 ? 23 : 11)
            }
        }
        .frame(width: 109, height: 6)
    }
}

struct DotsProgressView_Previews: PreviewProvider {
    static var previews: some View {
        DotsProgressView(dotsCount: 8, selectedIndex: .constant(7))
    }
}
