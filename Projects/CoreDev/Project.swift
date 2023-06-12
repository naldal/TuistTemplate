import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "CoreDev"
let project = Project.makeModule(
  name: projectName,
  product: .app,
  additionalTargets: [],
  additionalSourcePaths: [],
  additionalResourcePaths: []
)
