import ProjectDescription

public extension Project {
  
  /// This method operates based on folder hierarchy.
  /// Please pay attention to the instructions in order to create your modules and workspace effectively.
  ///
  /// Firstly, you need to create "Sources" and "Resources" folders within your ${Core project folder}/Targets/${Core target folder}.
  /// Consequently, you should also create the "Targets" and "Core target folder".
  ///
  /// For example:
  /// ${Root}/Projects/${Core Project Name}/Targets/${Core Project Name}/Sources
  /// ${Root}/Projects/${Core Project Name}/Targets/${Core Project Name}/Resources
  ///
  /// Secondly, your custom info.Plist, headers and other support files should be located in the Core project folder/Support folder.
  ///
  /// For example:
  /// ${Root}/Projects/${Core Project Name}/Support/Common.h
  /// ${Root}/Projects/${Core Project Name}/Support/info.Plist
  ///
  /// Thirdly, this method supports the creation of build settings based on .xcconfig files.
  /// Therefore, you need to create appropriate .xcconfig files for each configuration.
  /// Your xcconfig file should be located in your Target/XCConfigs folder
  ///
  /// For example:
  /// ${Root}/Projects/${Core Project Name}/Targets/${Core target Name}/XCConfigs/Core.xcconfig
  static func makeModule(
    name: String,
    platform: Platform = .iOS,
    product: Product,
    baseBundleId: String = "com.tuistTemplate",
    organizationName: String = "organizationName",
    packages: [Package] = [],
    deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [TargetDependency] = [],
    testDependencies: [TargetDependency] = [],
    bridgingHeaderPath: String? = nil,
    customInfoPlist: InfoPlist = .default,
    additionalTargets: [String],
    isIncludeOnly: Bool = false
  ) -> Project {
    
    
    // MARK: - Declare origin name
    
    /// the origin name is relavent with your 'Core' Project.
    /// When you change your name of Core Project, you have to change this origin name as well.
    var originName: String {
      return "Core"
    }
    
    
    // MARK: - Targets
    
    let targetAdditionalSourcePath: [String] = [
      "../\(originName)/Targets/\(originName)/Sources/**"
    ]
    
    let targetAdditionalResourcePath: [String] = [
      "../\(originName)/Targets/\(originName)/Resources/**"
    ]
    
    let targets: [Target] = self.makeTargets(
      targetName: name,
      originName: originName,
      platform: platform,
      product: product,
      baseBundleId: baseBundleId,
      deploymentTarget: deploymentTarget,
      dependencies: dependencies,
      testDependencies: testDependencies,
      additionalSourcePaths: targetAdditionalSourcePath,
      additionalResourcePaths: targetAdditionalResourcePath,
      isIncludeOnly: isIncludeOnly
    )
    
    
    // MARK: - Build settings
    
    /// Header is for interaction between Swift and Object-C language so you have to make your own header file.
    /// This Project has already a header file on Core/Support. Customize it as your needs.
    var baseSetting: ProjectDescription.SettingsDictionary {
      if let bridgingHeaderPath {
        return ["SWIFT_OBJC_BRIDGING_HEADER": SettingValue(stringLiteral: bridgingHeaderPath)]
      }
      return [:]
    }
    
    /// Settings is for your Configurations such as Debug and Release.
    /// You can Add custom Configuration but you have to make proper .xcconfig to setting the configuration
    let settings: Settings = .settings(
      base: [:],
      configurations: [
        .debug(
          name: .debug,
          settings: baseSetting,
          xcconfig: "../\(originName)/Targets/\(originName)/XCConfigs/Debug.xcconfig"
        ),
        .release(
          name: .release,
          settings: baseSetting,
          xcconfig: "../\(originName)/Targets/\(originName)/XCConfigs/Release.xcconfig"
        )
      ],
      defaultSettings: .recommended
    )

    return Project(
      name: name,
      organizationName: organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      resourceSynthesizers: []
    )
  }
  
  
  // MARK: - make multiple targets
  
  static func makeTargets(
    targetName: String,
    originName: String,
    platform: Platform,
    product: Product,
    baseBundleId: String,
    deploymentTarget: DeploymentTarget?,
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    additionalSourcePaths: [String],
    additionalResourcePaths: [String],
    isIncludeOnly: Bool
  ) -> [Target] {
    
    let sources: SourceFilesList = {
      if targetName != originName {
        let globs: [SourceFileGlob] = {
          var returnValue: [SourceFileGlob] = []
          if isIncludeOnly == false {
            returnValue.append(SourceFileGlob.glob("../\(targetName)/Targets/\(targetName)/Sources/**"))
          }
          for additionalSourcePath in additionalSourcePaths {
            returnValue.append(.glob(
              Path(additionalSourcePath),
              excluding: [
                "../\(originName)/Targets/\(originName)/Sources/AppDelegate.swift",
                "../\(originName)/Targets/\(originName)/Sources/SceneDelegate.swift"
              ]
            ))
          }
          return returnValue
        }()
        return SourceFilesList(globs: globs)
      } else {
        var returnValue: [String] = additionalSourcePaths
        returnValue.append("../\(originName)/Targets/\(originName)/Sources/**")
        return SourceFilesList(globs: returnValue)
      }
    }()
    
    let resources: ResourceFileElements = {
      if targetName != originName {
        var returnValue: [String] = additionalResourcePaths
        if isIncludeOnly == false {
          returnValue.append("../\(targetName)/Targets/\(targetName)/Resources/**")
        }
        var elements: [ResourceFileElement] = []
        for item in returnValue {
          elements.append(.init(stringLiteral: item))
        }
        return ResourceFileElements(resources: elements)
      } else {
        var returnValue: [String] = additionalResourcePaths
        returnValue.append("../\(originName)/Targets/\(originName)/Resources/**")
        var elements: [ResourceFileElement] = []
        for item in returnValue {
          elements.append(.init(stringLiteral: item))
        }
        return ResourceFileElements(resources: elements)
      }
    }()
    
    // add your own scripts
    let scripts: [TargetScript] = [
      TargetScript.makeScript(
        order: .pre,
        scriptPath: "../Tool/Lint/swiftlint --config \"../Tool/Lint/swiftlint.yml\"",
        name: "Lint"
      )
    ]
    
    let mainTarget = Target(
      name: targetName,
      platform: platform,
      product: product,
      bundleId: "\(baseBundleId).\(targetName)",
      deploymentTarget: deploymentTarget,
      infoPlist: .file(path: "../\(originName)/Support/InfoPlist/Info.plist"),
      sources: sources,
      resources: resources,
      scripts: scripts,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(targetName)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "\(baseBundleId).\(targetName)Tests",
      deploymentTarget: deploymentTarget,
      infoPlist: .file(path: "../\(originName)/Support/InfoPlist/Info.plist"),
      sources: ["../\(originName)/Targets/\(originName)/Tests/**"],
      resources: ["../\(originName)/Targets/\(originName)/TestResources/**"],
      dependencies: testDependencies
    )
    
    return [mainTarget, testTarget]
  }
}
