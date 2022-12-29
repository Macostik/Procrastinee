//
//  DependencyProvider.swift
//  Procrastinee
//
//  Created by Macostik on 29.12.2022.
//

import Foundation
import Combine
import SwiftUI
import HYSLogger

protocol DependencyProvider {
    var provider: Provider { get set }
}

private struct DependencyKey: EnvironmentKey {
  static let defaultValue = Dependency(provider: Provider())
}

extension EnvironmentValues {
  var dependency: Dependency {
    get { self[DependencyKey.self] }
    set { self[DependencyKey.self] = newValue }
  }
}

struct Dependency: DependencyProvider {
    var provider: Provider
    init(provider: Provider) {
        Logger.debug("Init dependency")
        self.provider = provider
    }
}
