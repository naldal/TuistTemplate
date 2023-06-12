import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "CoreUIPreview"
let project = Project.makeModule(
  name: projectName,
  product: .app,
  additionalTargets: [],
  additionalSourcePaths: [],
  additionalResourcePaths: []
)
