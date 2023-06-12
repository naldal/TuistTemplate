//
//  Project+Dependency.swift
//  ProjectDescriptionHelpers
//
//  Created by Russell Hamin Song on 2023/06/12.
//

import ProjectDescription

public extension TargetDependency {
  static let quick: TargetDependency = .external(name: "Quick")
  static let nimble: TargetDependency = .external(name: "Nimble")
}
