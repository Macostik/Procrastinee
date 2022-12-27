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
struct TrackableScrollView<Content: View>: View {
    @ViewBuilder let content: (ScrollViewProxy) -> Content

    let onContentSizeChange: (CGSize) -> Void
    let onOffsetChange: (CGPoint) -> Void

    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                GeometryReader { geo in
                    Color.clear.preference(
                        key: ScrollOffsetKey.self,
                        value: geo.frame(in: .named("scrollView")).origin
                    )
                    .frame(width: 0, height: 0)
                }
                content(reader)
                    .background(
                        GeometryReader { geo -> Color in
                            DispatchQueue.main.async {
                                onContentSizeChange(geo.size)
                            }
                            return Color.clear
                        }
                    )
            }
            .coordinateSpace(name: "scrollView")
            .onPreferenceChange(ScrollOffsetKey.self) { offset in
                onOffsetChange(offset)
            }
        }
    }
}

private struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue = CGPoint.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {}
}
