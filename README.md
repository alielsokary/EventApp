

![event-app-title-icon](https://user-images.githubusercontent.com/11244927/138174675-4c1f9ecf-c922-4639-bc49-6ed6a6ef7de2.png)





[![Build Status](https://app.bitrise.io/app/cc6971c2a44ce2b3/status.svg?token=DAmcQTtkwVzD3iJCO5RI-A)](https://app.bitrise.io/app/cc6971c2a44ce2b3) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/9f3e735b8990457b9a4f80c98b6ef734)](https://app.codacy.com/gh/alielsokary/EventApp?utm_source=github.com&utm_medium=referral&utm_content=alielsokary/EventApp&utm_campaign=Badge_Grade_Settings)

## Project Structure

```
.
├── EventApp
│   │   ├── App             # cotnains `AppDelegate` and `AppCoordinator`
│   │   ├── Library         # contains Helper/Extensions files
│   │   │   └── Extension 
│   │   ├── Models         
│   │   ├── Storyboards     
│   │   ├──  Services       # contains network and  storage services 
│   │   ├── Scenes          # contains all app Scenes
│   │   │   └── ${Module}   # contains concrete module, its structure is described in Layered architecture 
│   │   ├──  Unit-Tests     
└── Pods
```



## Architecture description
### Design Pattern
The app designed with the **MVVM-C** pattern with RxSwift for data binding.
The coordinator is responsible for dependency injection and navigation decisions.

### Modular development
Application is separated into small units with similar functionality that can be developed independently.
### Layered architecture

Each module is divided by layers:

```
├── Coordinator
├── Service
├── ViewModel
├── View
│   ├── Cell
│   └── Layout
```

### Dependencies

- **Alamofire**
- **AlamofireNetworkActivityLogger**
- **RxSwift**
- **Realm**
- **R.swift**
- **SwiftLint**
- **PKHUD**
