//
//  FirstIntroductionView.swift
//  Procrastinee
//
//  Created by Macostik on 09.12.2022.
//

import SwiftUI

struct FirstIntroductionView: View {
    var body: some View {
        VStack {
            Image.procrasteeImage
                .resizable()
                .frame(width: 138, height: 32)
                .scaledToFit()
            Spacer()
            Image.firstIntroduction
            Spacer()
        }
    }
}

struct FirstIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        FirstIntroductionView()
    }
}
