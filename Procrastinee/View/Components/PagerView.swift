//
//  PagerView.swift
//  Procrastinee
//
//  Created by Macostik on 28.12.2022.
//

import SwiftUI

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var canDrag: Bool
    @Binding var currentIndex: Int
    let content: Content
    init(pageCount: Int, canDrag: Binding<Bool>, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._canDrag = canDrag
        self._currentIndex = currentIndex
        self.content = content()
    }
    @GestureState private var translation: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.easeInOut, value: currentIndex)
            .animation(.interactiveSpring(), value: translation)
            .gesture(!canDrag ? nil :
                        DragGesture()
                .updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }
                .onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}

struct PagerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
