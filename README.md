## Project: "clean-architecture-tdd-flutter-template"

This repository serves as a comprehensive template for building Flutter applications following best practices in software architecture and development methodologies. It incorporates the following key components:

1. **Domain-Driven Design (DDD) Architecture**: The project is structured around the principles of DDD, promoting a clear separation of concerns and a focus on domain logic.

2. **Test-Driven Development (TDD) Architecture**: Test cases are written before the implementation to ensure code correctness and reliability. TDD is embraced throughout the development process.

3. **BLoC State Management**: Business Logic Component (BLoC) pattern is utilized for managing application state, providing a robust and scalable solution for handling complex state management scenarios.

4. **Provider State Management**: In addition to BLoC, Provider pattern is also employed for state management, offering flexibility and simplicity where it fits best.

5. **Dependency Injection**: The project integrates dependency injection to facilitate loose coupling and improve testability by enabling easier mocking of dependencies.

6. **Router**: A navigation router is implemented to manage navigation flow within the application, ensuring a consistent and structured user experience.

### Project Structure:

```
clean-architecture-tdd-flutter-template/
│
├── lib/                                  # Main source code directory
│   ├── core/                             # Core domain logic and utilities
|   |   ├── common/                       # Common utilities and shared components
|   |   |   ├── app/                      # Application-specific components and providers
|   |   |   |   └── providers/            # Providers for State Management
|   |   |   ├── views/                    # Reusable UI components
|   |   |   └── widgets/                  # Generic widgets
|   |   ├── enums/                        # Enumerations used in the domain
|   |   ├── errors/                       # Error handling and exception classes
|   |   ├── extensions/                   # Extension methods for built-in Dart types
|   |   ├── res/                          # Resource files such as images or fonts
|   |   ├── services/                     # External services and infrastructure dependencies
|   |   |   ├── injection_container.dart  # Dependency injection setup
|   |   |   └── router.dart               # Routing configuration
|   |   ├── usecase/                      # Use cases type representing business logic
|   |   └── utils/                        # Utility functions and helpers
│   ├── src/                              # Feature-specific code
|   |   └── example_feature/              # Example feature module
|   |       ├── data/                     # Data layer components
|   |       |   ├── datasources/          # Data sources (e.g., APIs, databases)
|   |       |   ├── models/               # Data models and mappers
|   |       |   └── repository_impl/      # Implementations of data repositories
|   |       ├── domain/                   # Domain layer components
|   |       |   ├── entities/             # Domain entities representing business concepts
|   |       |   ├── repository/           # Interfaces for data repositories
|   |       |   └── usecases/             # Use cases implementing business logic
|   |       └── presentation/             # Presentation layer components
|   |           ├── bloc/                 # Business Logic Components for state management
|   |           ├── refactors/            # Refactored UI components or business logic
|   |           ├── views/                # Screens or UI components
|   |           └── widgets/              # Reusable widgets specific to the feature
│   └── main.dart                         # Application entry point
│                  
│
├── test/                                 # Test directory for TDD
│   ├── fixtures/                         # Test fixtures for common setup or mock data
│   └── src/                              # Source code specific tests
|       └── example_feature/              # Example feature module tests
|           ├── data/                     # Data layer tests
|           |   ├── datasources/          # Data source tests
|           |   └── models/               # Data model tests
|           ├── domain/                   # Domain layer tests
|           |   └── usecases/             # Use case tests
|           └── presentation/             # Presentation layer tests
|               └── bloc/                 # BLoC tests
│
├── README.md                             # Project documentation and usage guide
└── pubspec.yaml                          # Flutter project dependencies and metadata

```

### Credits
This template is created by Jabalnur.
