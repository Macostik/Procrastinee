//
//  View+Modifier.swift
//  Procrastinee
//
//  Created by Macostik on 19.12.2022.
//

import SwiftUI

struct DraggableModifier: ViewModifier {
    enum Direction {
        case vertical
        case horizontal
    }
    let direction: Direction
    @State var draggedOffset: CGFloat = 0
    func body(content: Content) -> some View {
        content
        .offset(
            CGSize(width: direction == .vertical ? 0 : draggedOffset,
                   height: direction == .horizontal ? 0 : draggedOffset)
        )
        .gesture(
            DragGesture()
            .onChanged { value in
                self.draggedOffset =  direction == .vertical ?
                value.location.y : value.location.x
            }
            .onEnded { _ in
                self.draggedOffset = .zero
            }
        )
    }
}
