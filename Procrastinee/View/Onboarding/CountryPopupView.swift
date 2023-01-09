//
//  CountryPopupView.swift
//  Procrastinee
//
//  Created by Macostik on 26.12.2022.
//

import SwiftUI

var countryCodeList: [String] {
    var list: [String] = []
    for code in NSLocale.isoCountryCodes {
        if code == "RU" || code == "BY" || code == "AX" {
            continue
        } else {
            let name = name(by: code)
            list.append(name +  "_" + code)
        }
    }
    list.sort(by: <)
    return list
}

func name(by code: String) -> String {
    let id = NSLocale
        .localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
    return NSLocale(localeIdentifier: "en_UK")
        .displayName(forKey: NSLocale.Key.identifier, value: id) ?? ""
}

func emojiFlag(by code: String) -> String {
    func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
        return scalar.value >= 0x61 && scalar.value <= 0x7A
    }
    func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
        precondition(isLowercaseASCIIScalar(scalar))
        return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
    }
    let lowercasedCode = code.lowercased()
    guard lowercasedCode.count == 2 else { return "" }
    guard lowercasedCode.unicodeScalars
        .allSatisfy({ scalar in  isLowercaseASCIIScalar(scalar) })
    else { return "" }
    let indicatorSymbols =
    lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
    return String(indicatorSymbols.map({ Character($0) }))
}

struct CountryPopupView: View {
    @StateObject var viewModel: OnboardingViewModel
    @State var offset: CGFloat = 0.0
    var body: some View {
        VStack {
            Picker("", selection: $viewModel.selectedCountry) {
                ForEach(countryCodeList, id: \.self) { value in
                    let value = value.components(separatedBy: "_")
                    let name = value.first ?? ""
                    let code = value.last ?? ""
                    Text(emojiFlag(by: code) + " " + name)
                        .font(.system(size: 23).weight(.medium))
                        .foregroundColor(Color.black)
                }
            }
            .pickerStyle(.wheel)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.cf8Fafb)
        .offset(y: self.offset)
        .gesture(DragGesture()
            .onChanged({ gesture in
                if gesture.location.y > 0 &&
                    gesture.startLocation.y < 100 {
                    offset = gesture.translation.height
                }
            })
                .onEnded({ _ in
                    viewModel.isCountyPopupPresented = !(offset > 200)
                    offset = 0
                })
        )
        .clipShape(RoundedCorner(radius: 10,
                                 corners: [.topLeft, .topRight]))
    }
}

struct CountryPopupView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPopupView(viewModel: OnboardingViewModel())
    }
}
