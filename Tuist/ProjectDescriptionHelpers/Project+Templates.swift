import ProjectDescription

public extension Project {
  
  ///
  /// This method force the folders hiearchy.
  /// Be aware the description to make your modules and workspace.
  ///
  /// At First, you have to make Sources and Resources folder in your Project folder (e.g. ${Root}/Projects/${Your Project Name}/Sources)
  /// Second, Your custom Info.Plist, Header and scripts must be located in Support folder (e.g. ${Root}/Projects/${Your Project Name}/Support)
  /// Third, this method support to make build settings based on .xcconfig. So you have to make proper .xcconfig for each Configurations.
  ///
  static func makeModule(
    name: String,
    platform: Platform = .iOS,
    product: Product,
    baseBundleId: String = "com.tuistTemplate",
    organizationName: String = "organizationName",
    packages: [Package] = [],
    deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: [.iphone, .ipad]),
    dependencies: [TargetDependency] = [],
    testDependencies: [TargetDependency] = [],
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements = ["Resources/**"],
    bridgingHeaderPath: String? = nil,
    customInfoPlist: InfoPlist = .default,
    additionalTargets: [String],
    additionalSourcePaths: [String],
    additionalResourcePaths: [String]
  ) -> Project {
    
    
    // MARK: - Targets
    
    let targets: [Target] = self.makeTargets(
      name: name,
      platform: platform,
      baseBundleId: baseBundleId,
      dependencies: dependencies,
      testDependencies: testDependencies,
      additionalSourcePaths: additionalSourcePaths,
      additionalResourcePaths: additionalResourcePaths
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
          xcconfig: ""
        ),
        .release(
          name: .release,
          settings: baseSetting,
          xcconfig: ""
        )
      ],
      defaultSettings: .none
    )

    // MARK: - Make a Project
    
    return Project(
      name: name,
      organizationName: organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      additionalFiles: [],
      resourceSynthesizers: []
    )
  }
  
  static func makeTargets(
    name: String,
    platform: Platform,
    baseBundleId: String,
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    additionalSourcePaths: [String],
    additionalResourcePaths: [String]
  ) -> [Target] {
    
    return []
  }
}
