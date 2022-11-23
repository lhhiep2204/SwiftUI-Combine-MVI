# HH SwiftUI Template
This template is intended to reduce the time it takes to create a new project.
- **SwiftUI - Combine - MVI**

## Contents

- [Setup](#setup)
- [Usage](#usage)

## Setup
Copy `File Templates` and `Project Templates` folder, then paste it in `~/Library/Developer/Xcode/Templates`.

## Usage
### Create project template
Create new project and scroll to the botton, then select `HH SwiftUI Template` in `Project Templates` category.

<img width="739" alt="Screen Shot 2022-09-27 at 18 22 47" src="https://user-images.githubusercontent.com/46402339/192512781-5234ce4e-2e8f-461f-862a-8dddb2ab48b6.png">

**Note:**

> Replace the content in `[ProjectName]App` struct of the `[ProjectName]App.swift` file with the code below:

```swift
@StateObject var appRouter = AppRouter()

@ViewBuilder
var rootView: some View {
    switch self.appRouter.state {
    case .launchScreen:
        LaunchScreenView()
    case .login:
        LoginView()
    case .home:
        HomeView()
    }
}

var body: some Scene {
    WindowGroup {
        self.rootView
            .environmentObject(self.appRouter)
    }
}
```

### Create file template
Create new file and scroll to the bottom, then select `HH Intent File` or `HH SwiftUI File` in `File Templates` category.

<img width="734" alt="Screen Shot 2022-09-27 at 18 11 00" src="https://user-images.githubusercontent.com/46402339/192511783-5be46c02-1122-4e73-92e6-d43c0735eb52.png">
