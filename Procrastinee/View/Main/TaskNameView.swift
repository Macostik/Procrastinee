//
//  TaskNameView.swift
//  Procrastinee
//
//  Created by Macostik on 19.12.2022.
//

import SwiftUI

struct TaskNameView: View {
    var action: (() -> Void)?
    var body: some View {
        VStack(spacing: 0) {
            TaskNameHeaderView()
            TaskNameTextField(action: action)
            Spacer()
        }
    }
}

struct TaskNameView_Previews: PreviewProvider {
    static var previews: some View {
        TaskNameView()
    }
}

struct TaskNameHeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(L10n.Task.name)
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(Color.c253456)
            Text(L10n.Task.theName)
                .font(.system(size: 18).weight(.medium))
                .foregroundColor(Color.cadadad)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
        }
        .padding(.top, 90)
    }
}
struct TaskNameTextField: View {
    var action: (() -> Void)?
    @State var taskName = ""
    @FocusState private var isFocused: Bool
    @State var textFontColor = Color.ccfd0D4
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(Color.white)
                .frame(maxHeight: 66)
                .shadow(color: Color.c2F2E41.opacity(0.1), radius: 6)
                .overlay {
                    HStack {
                        TextField(L10n.Task.namePlaceholder, text: $taskName)
                            .font(.system(size: 18).weight(.regular))
                            .foregroundColor(textFontColor)
                            .focused($isFocused)
                            .onChange(of: taskName) { newValue in
                                textFontColor = newValue.count > 0 ?
                                Color.black : Color.ccfd0D4
                            }
                        Spacer()
                        Button {
                            if taskName.isEmpty == false {
                                isFocused = false
                                action?()
                            }
                        } label: {
                            Image.successMark
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal, 29)
        }
        .padding(.top, 40)
        .onAppear {
            isFocused = true
        }
    }
}
