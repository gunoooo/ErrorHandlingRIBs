import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ErrorHandlingRIBs",
    organizationName: "com.gunoooo",
    packages: [
        .package(url: "https://github.com/uber/RIBs", from: "0.10.0")
    ],
    targets: Project.appTargets(
        name: "ErrorHandlingRIBs",
        appDependencies: [
            .ribs
        ],
        testDependencies: []
    ),
    schemes: [],
    additionalFiles: []
)
