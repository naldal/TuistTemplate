//
//  Project+Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by Russell Hamin Song on 2023/06/12.
//

import ProjectDescription

extension Project {
  
  public static func makeFramework(
    name: String,
    frameworkType: Product = .staticFramework,
    baseBundleId: String,
    customInfoPlist: InfoPlist,
    scripts: [TargetScript],
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency]
  ) -> [Target] {
    
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: frameworkType,
      bundleId: "\(baseBundleId).\(name)",
      infoPlist: customInfoPlist,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: scripts,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: name,
      platform: .iOS,
      product: .unitTests,
      bundleId: "\(baseBundleId).\(name)Tests",
      infoPlist: .default,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [.target(name: name)] + testDependencies
    )
    
    let sampleApp = Target(
      name: name,
      platform: .iOS,
      product: .app,
      bundleId: "\(baseBundleId).\(name)SampleApp",
      infoPlist: customInfoPlist,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [.target(name: name)]
    )
    
    return [mainTarget, testTarget, sampleApp]
  }
}
