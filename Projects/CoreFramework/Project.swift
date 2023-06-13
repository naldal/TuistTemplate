import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "CoreFramework"
let project = Project(
  name: projectName,
  targets: Project.makeFrameworkTargets(
    name: projectName,
    customInfoPlist: .default,
    scripts: [],
    dependencies: [],
    testDependencies: [.quick, .nimble]
  )
)
