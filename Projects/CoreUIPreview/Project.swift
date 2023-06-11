import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "CoreUIPreview",
    platform: .iOS,
    product: .app,
    dependencies: [],
    infoPlist: .default
)
