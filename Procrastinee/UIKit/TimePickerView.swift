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
    case hour, minute
    var description: [String] {
        switch self {
        case .hour: return (1..<25).map({"\($0)"})
        case .minute: return (1..<61).map({"\($0)"})
        }
    }
}

struct TimePickerView: UIViewRepresentable {
    @Binding var selectedItem: String
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var selectedItem: Binding<String>
        init(selectedItem: Binding<String>) {
          self.selectedItem = selectedItem
        }
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            2
        }
        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            TimePickerData.allCases[component].description.count
        }
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            TimePickerData.allCases[component].description[row]
        }
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            self.selectedItem.wrappedValue =
            TimePickerData.allCases[component].description[row]
        }
        func pickerView(_ pickerView: UIPickerView,
                        viewForRow row: Int,
                        forComponent component: Int,
                        reusing view: UIView?) -> UIView {
            let label = UILabel()
            label.text = TimePickerData.allCases[component].description[row]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
            return label
        }
        func pickerView(_ pickerView: UIPickerView,
                        widthForComponent component: Int) -> CGFloat {
            return 84
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedItem: $selectedItem)
    }
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIView(_ picker: UIPickerView, context: Context) {}
}

struct RangeDatePicker: UIViewRepresentable {
    @Binding var selectedItem: Date
    class Coordinator: NSObject {
        var selectedItem: Binding<Date>
        init(selectedItem: Binding<Date>) {
          self.selectedItem = selectedItem
        }
        @objc func handleDatePicker(_ datePicker: UIDatePicker) {
            selectedItem.wrappedValue = datePicker.date
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedItem: $selectedItem)
    }
    func makeUIView(context: Context) -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(context.coordinator, action: #selector(Coordinator.handleDatePicker), for: .valueChanged)
        return picker
    }
    func updateUIView(_ picker: UIDatePicker, context: Context) {}
}
