import ProjectDescription

extension Project {
    public static func appTargets(
        name: String,
        appDependencies: [TargetDependency],
        testDependencies: [TargetDependency]
    ) -> [Target] {
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
        ]

        let mainTarget = Target(
            name: name,
            platform: .iOS,
            product: .app,
            bundleId: "com.github.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["\(name)/Sources/**"],
            resources: ["\(name)/Resources/**"],
            dependencies: appDependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.github.\(name)Tests",
            infoPlist: .default,
            sources: ["\(name)/Tests/**"],
            dependencies: [.target(name: "\(name)")] + testDependencies
        )
        return [mainTarget, testTarget]
    }
}
