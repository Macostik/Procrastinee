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
        var hourValue = "1"
        var minuteValue = "05"
        var period = "AM"
        var didSelectRow = false
        var timeValue: Binding<String>
        init(timeValue: Binding<String>, didSelectRow: Bool = false) {
            self.timeValue = timeValue
            self.didSelectRow = didSelectRow
            let roundDate = roundDate()
            hourValue = "\(roundDate.0)"
            minuteValue = "\(roundDate.1)"
            period = roundDate.2 ? "PM" : "AM"
            timeValue.wrappedValue = hourValue + ":" + minuteValue + " " + period
        }
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            pickerView.subviews.first?.backgroundColor = .clear
            pickerView.subviews.last?.backgroundColor = .clear
            return 3
        }
        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            return TimePickerData.allCases[component].description.count
        }
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            return TimePickerData.allCases[component].description[row]
        }
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            didSelectRow = true
            let value = TimePickerData.allCases[component].description[row]
            if component == 0 {
                hourValue = value
            } else if component == 1 {
                minuteValue = value
                if minuteValue == "5" {
                    minuteValue = "05"
                }
            } else {
                period = value
            }
            didSelectRow = true
            timeValue.wrappedValue = hourValue + ":" + minuteValue + " " + period
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
    func updateUIView(_ picker: UIPickerView, context: Context) {
        let roundDate = roundDate()
        if context.coordinator.didSelectRow == false {
            let firstRow = TimePickerData.hour.description.firstIndex(of: "\(roundDate.0)") ?? 0
            let secondRow = TimePickerData.minute.description.firstIndex(of: "\(roundDate.1)") ?? 0
            picker.selectRow(firstRow, inComponent: 0, animated: false)
            picker.selectRow(secondRow, inComponent: 1, animated: false)
            picker.selectRow(roundDate.2 ? 1 : 0, inComponent: 2, animated: false)
        }
    }
}
typealias RoundDateType = (Int, Int, Bool)
func roundDate() -> RoundDateType {
    let date = Date()
    let calendar = Calendar.current
    var hour = calendar.component(.hour, from: date)
    let isPm = hour > 12
    hour = isPm ? hour - 12 : hour
    let minutes = calendar.component(.minute, from: date)
    let roundedMinute = lrint(Double(minutes) / Double(5)) * 5
    return (hour, roundedMinute, isPm)
}
