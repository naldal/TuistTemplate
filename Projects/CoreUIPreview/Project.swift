import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "CoreUIPreview"
let project = Project.makeModule(
    name: projectName,
    platform: .iOS,
    product: .app,
    dependencies: [],
    infoPlist: .default
)
