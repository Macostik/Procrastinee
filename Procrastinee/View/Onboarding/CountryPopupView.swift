//
//  CountryPopupView.swift
//  Procrastinee
//
//  Created by Macostik on 26.12.2022.
//

import SwiftUI

struct CountryPopupView: View {
    @StateObject var viewModel: OnboardingViewModel
    @State var offset: CGFloat = 0.0
    var body: some View {
        VStack {
            Picker("", selection: $viewModel.selectedCountry) {
                ForEach(viewModel.countryList, id: \.self) { value in
                    Text(value)
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
