import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "CoreNetwork"
let project = Project.makeModule(
  name: projectName,
  product: .staticFramework,
  additionalTargets: [],
  additionalSourcePaths: [],
  additionalResourcePaths: []
)
