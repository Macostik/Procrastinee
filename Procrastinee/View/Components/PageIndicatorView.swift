//
//  PageIndicatorView.swift
//  Procrastinee
//
//  Created by Macostik on 10.12.2022.
//

import SwiftUI

struct PageIndicatorView: View {
    @Binding var selected: Int
    var body: some View {
        HStack(spacing: 10) {
            ForEach(1..<4) { index in
                Circle()
                    .foregroundColor(index <= selected ? Color.black : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

struct PageIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        PageIndicatorView(selected: .constant(1))
    }
}
