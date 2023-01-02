//
//  СarouselView.swift
//  Procrastinee
//
//  Created by Macostik on 22.12.2022.
//

import Foundation
import SwiftUI

struct СarouselView: View {
    var dataList: [Int]
    var multiplayValue = 1
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @Binding var selectedValue: Int
    var body: some View {
        ZStack {
            ForEach(dataList, id: \.self) { item in
                ZStack {
                    Text("\(item * multiplayValue)min")
                        .font(.system(size: 38).weight(.thin))
                        .foregroundColor(Color.black)
                        .padding(25)
                }
                .scaleEffect(1.0 - abs(distance(item)) * 0.25)
                .opacity(1.0 - abs(distance(item)) * 0.5)
                .offset(x: myXOffset(item), y: 0)
                .zIndex(1.0 - abs(distance(item)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(dataList.count))
                        snappedItem = draggingItem
                        let index = ((dataList.count - 1) - Int(draggingItem)) % dataList.count
                        selectedValue = dataList[index] * multiplayValue
                    }
                }
        )
    }
    func distance(_ item: Int) -> Double {
        return (draggingItem + Double(item)).remainder(dividingBy: Double(dataList.count))
    }
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(dataList.count) * distance(item)
        return sin(angle) * 225
    }
}

struct СarouselView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 70) {
            СarouselView(dataList: Array(1...12), selectedValue: .constant(0))
            СarouselView(dataList: Array(1...12), multiplayValue: 5, selectedValue: .constant(0))
        }
    }
}
