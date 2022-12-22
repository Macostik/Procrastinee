//
//  GradientStyle.swift
//  Procrastinee
//
//  Created by Macostik on 16.12.2022.
//

import SwiftUI
import UIKit

struct GradientStyle: ShapeStyle {}
let gradient = LinearGradient(colors:
                                [Color.startPointColor,
                                 Color.endPointColor],
                              startPoint: .leading,
                              endPoint: .trailing)
let gradientVertical = LinearGradient(colors:
                                [Color.startPointColor,
                                 Color.endPointColor],
                              startPoint: .top,
                              endPoint: .bottom)
let promodoroGradient = LinearGradient(colors:
                                        [Color.promodoroStartGradientColor,
                                         Color.promodoroEndGradientColor],
                                       startPoint: .leading,
                                       endPoint: .trailing)
