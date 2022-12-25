//
//  ScrollableScrollView.swift
//  Procrastinee
//
//  Created by Macostik on 25.12.2022.
//

import SwiftUI

struct ScrollableScrollView<Content: View>: View {
    var scrollDisable: Bool
    let content: Content?
    init(scrollDisable: Bool = false,
         @ViewBuilder content: () -> Content?) {
        self.scrollDisable = scrollDisable
        self.content = content()
    }
    var body: some View {
        if #available(iOS 16.0, *) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    content
                }
            }
            .scrollDisabled(scrollDisable)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    content
                }
            }
        }
    }
}

struct ScrollableScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableScrollView(content: {})
    }
}
