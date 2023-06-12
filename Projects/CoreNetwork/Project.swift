//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Russell Hamin Song on 2023/06/12.
//

import ProjectDescription

let projectName = "CoreNetwork"
let project = Project.makeModule(
    name: projectName,
    platform: .iOS,
    product: .app,
    dependencies: []
)
