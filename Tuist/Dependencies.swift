//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Russell Hamin Song on 2023/06/12.
//

import ProjectDescription

let dependencies = Dependencies(
  carthage: CarthageDependencies([]),
  swiftPackageManager: SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/Quick/Quick.git", requirement: .branch("master")),
    .remote(url: "https://github.com/Quick/Nimble.git", requirement: .branch("main"))
  ], productTypes: [
    "Quick": .staticFramework,
    "Nimble": .staticFramework
  ])
)
