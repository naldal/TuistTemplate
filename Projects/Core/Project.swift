import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Core",
    platform: .iOS,
    product: .app,
    dependencies: [],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
