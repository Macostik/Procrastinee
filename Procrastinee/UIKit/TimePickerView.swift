//
//  TimePickerView.swift
//  Procrastinee
//
//  Created by Macostik on 22.12.2022.
//

import Foundation
import UIKit
import SwiftUI

enum TimePickerData: CaseIterable {
    case hour, minute, period
    var description: [String] {
        switch self {
        case .hour: return (1...12).map({"\($0)"})
        case .minute: return (1..<12).map({"\($0 * 5)"})
        case .period: return ["AM", "PM"]
        }
    }
}

struct TimePickerView: UIViewRepresentable {
    @Binding var selectedTime: String
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        private var hourValue = "0"
        private var minuteValue = "0"
        private var period = "AM"
        var timeValue: Binding<String>
        init(timeValue: Binding<String>) {
            self.timeValue = timeValue
        }
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            pickerView.subviews.first?.backgroundColor = .clear
            pickerView.subviews.last?.backgroundColor = .clear
            return 3
        }
        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            TimePickerData.allCases[component].description.count
        }
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            return TimePickerData.allCases[component].description[row]
        }
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            let value = TimePickerData.allCases[component].description[row]
            if component == 0 {
                hourValue = value
            } else if component == 1 {
                minuteValue = value
            } else {
                period = value
            }
            timeValue.wrappedValue = hourValue + "." + minuteValue + period
        }
        func pickerView(_ pickerView: UIPickerView,
                        viewForRow row: Int,
                        forComponent component: Int,
                        reusing view: UIView?) -> UIView {
            let label = UILabel()
            label.text = TimePickerData.allCases[component].description[row]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
            label.textColor = UIColor.black
            return label
        }
        func pickerView(_ pickerView: UIPickerView,
                        widthForComponent component: Int) -> CGFloat {
            return 100
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(timeValue: $selectedTime)
    }
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIView(_ picker: UIPickerView, context: Context) {}
}
