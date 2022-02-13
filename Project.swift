import ProjectDescription
import ProjectDescriptionHelpers

/*
                +-------------+
                |             |
                |     App     | Contains ErrorHandlingRIBs App target and ErrorHandlingRIBs unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "ErrorHandlingRIBs",
                          platform: .iOS,
                          additionalTargets: ["ErrorHandlingRIBsKit", "ErrorHandlingRIBsUI"])
