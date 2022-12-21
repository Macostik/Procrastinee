//
//  GradientButton.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct GradientButton<Label>: View where Label: View {
    private let action: (() -> Void)?
    private let label: (() -> Label)?
    init(action: (() -> Void)? = nil, label: (() -> Label)? = nil) {
        self.action = action
        self.label = label
    }
    var body: some View {
        Button {
            self.action?()
        } label: {
            ZStack {
                gradient
                    .cornerRadius(14)
                    .frame(height: 50)
                label?()
            }
        }
    }
}

struct GradientButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
