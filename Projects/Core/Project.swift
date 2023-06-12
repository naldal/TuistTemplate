import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "Core"
let project = Project.makeModule(
  name: projectName,
  platform: .iOS,
  product: .app,
  dependencies: [],
  resources: ["Resources/**"],
  bridgingHeaderPath: "Support/BridgingHeader/Core-Bridging-Header.h",
  customInfoPlist: .file(path: "Support/InfoPlist/Info.plist"),
  additionalTargets: [],
  additionalSourcePaths: [],
  additionalResourcePaths: []
)
