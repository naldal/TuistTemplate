import ProjectDescription
import ProjectDescriptionHelpers

///
/// Note this projectName is literally "Core Name"
/// Other Project will be depended on this project.
///
let projectName = "Core"
let project = Project.makeModule(
  name: projectName,
  platform: .iOS,
  product: .app,
  dependencies: [],
  bridgingHeaderPath: "Support/BridgingHeader/Core-Bridging-Header.h",
  customInfoPlist: .file(path: "Support/InfoPlist/Info.plist"),
  additionalTargets: [],
  additionalSourcePaths: [],
  additionalResourcePaths: []
)
