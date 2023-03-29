## [0.1.0] - 2023-02-20

Basic implementation for generating a docx file based on docx file as template.

Already available for production usages.

### Features

- Create texts for docx
- Create tables for docx
- Create images for docx
- Create charts for docx ( Yet only readable for WPS )

## [0.2.0] - 2023-03-22

Mostly refactoring

### Features

- Support both `ox` and `nokogiri` as XML serializer

## [0.2.1] - 2023-03-23

### Features

- Support customize color and bold for Text

### Refactors

- Introduce `ActiveSupport` to make coding easier
- Clean irrelevant demos

## [0.2.2] - 2023-03-31(WIP)

### Features

- Add Github CI support


### Fixes

- Fix create charts issues
- Fix Nokogiri XML serializer compatible issues