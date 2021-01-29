# ATCustomViewTransitions

## Introduction

ATCustomViewTransition is a Swift Pacakge, that can help you manage transitions between views, similiar to what UIKit does with UIViewControllers (UIViewControllerTransitionDelegate).

This package can also help seperate the transition itself to a different class, and by that, keep the SOC (Separation Of Concerns) principle.

## Installation

### Swift Pacakge Manager

To use ATCustomViewTransitions with the Swift Package Manager, add a dependency to your Package.swift file:

```
let package = Package(
  dependencies: [
    .package(url: "https://github.com/AviTsadok/MyFirstSwiftPackage", .upToNextMajor(from: "1.0.0"))
  ]
)
```

## Usage

The usage of ADCustomViewTransition is very easy.

Just create a transition that conforms to ViewTransitionDelegate and call the view present method as the following example shows.
With the package, you can also find a ready made transition you can use (PopupViewTransition)

```
let newView = UIView()        
let popupViewTransition = PopupViewTransition()
self.view.present(presentedView: newView, fromView: nil, transitionDelegate: popupViewTransition)
```
