//
//  TrackerView.swift
//  Procrastinee
//
//  Created by Macostik on 15.12.2022.
//

import SwiftUI

struct TrackerView: View {
    var body: some View {
        Text("Tracker View")
            .foregroundColor(Color.onboardingTextColor)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundColor)
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    }
}
