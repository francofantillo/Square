## Build tools & versions used:

Build tooling is pretty straightforward for this app. I'm only using a single third-party framework (added using SPM), so it should just build and run.

## Steps to run the app:

The steps are as follows:

Unzip the project.
Build and run the project.
## What areas of the app did you focus on?

My primary focus on this app was to create an easily testable, efficient, and straightforward HttpClient for communicating with the employee server. The whole app is built around retrieving and displaying this data, so I wanted this component to work well. Furthermore, all of my unit testing revolves around this part of the app as well. There can be a lot of variety and possibilities for different responses when working with networking code, so I try to cover most of, if not all of the edge cases. You can see this in the HttpClient.swift file.

I try to make use of several of Swift's features to allow for more readable code. This includes using async/await, protocol inheritance, specifically Codable protocols, and throwing errors. Using these features makes it much easier to write code that is useful, easy to read, and efficient.

Some of the benefits include easily handling and displaying any networking errors to the user, being able to test most of the networking response cases, and avoiding unnecessary completion handlers.

I try to stick to using MVC architecture for this project. It's tried and true and works well for small projects.

I tried to keep the UI simple but appealing. I find SwiftUI is much faster for developing UI, so I chose to use it for creating the employee cells.

## What was the reason for your focus? What problems were you trying to solve?

I believe it's important to ensure that you capture and handle edge cases in networking. Creating an easily testable HttpClient will definitely help in solving that problem. Properly handling, propagating, and displaying errors will improve any debugging in the future, allowing developers to more easily see what went wrong, as well as enabling users to describe any issues that they might encounter.

Async/await makes asynchronous code much easier to read and greatly reduces reliance on completion handlers.

## How long did you spend on this project?

I spent 6 hours on this project.

## Did you make any trade-offs for this project? What would you have done differently with more time?

I would have liked to have implemented MVVM architecture. It simplifies UI code and makes business logic easier to test in the view models. I also would have liked to have done more testing with the business logic in the main view controller.

## What do you think is the weakest part of your project?

Similar to what I wrote above, I would have liked to have further separated the business logic from the view using MVVM architecture and used those benefits to write more tests.

## Did you copy any code or dependencies? Please make sure to attribute them here!

My HttpClient is mostly derived from this blog post:

https://medium.com/@koromikoneo/the-complete-guide-to-network-unit-testing-in-swift-db8b3ee2c327

I've added support for async/await, which I think helps the readability of my tests. It makes it much easier to test asynchronous code. I also added the ability to cancel network requests.

I used this library for caching the employee images:

https://github.com/lorenzofiamingo/swiftui-cached-async-image

## Is there any other information you’d like us to know?

I think that's all.
