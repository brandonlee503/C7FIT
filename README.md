# C7FIT

### Meta
- State: development
- Point people: 
[@brandonlee503](https://github.com/brandonlee503), 
[@rutgerfarry](https://github.com/rutgerfarry), 
[@willmichael](https://github.com/willmichael)
- CI: [![Build Status](https://travis-ci.org/iOS-Capstone/C7FIT.svg?branch=dev)](https://travis-ci.org/iOS-Capstone/C7FIT)

## Introduction
A fitness app allowing customers of [Club 7 Fitness](http://www.club7fitness.com/) to track their workouts and purchase fitness equipment.

[Rutger Farry](https://github.com/rutgerfarry), [Brandon Lee](https://github.com/brandonlee503), and [Michael Lee's](https://github.com/willmichael) senior project at Oregon State University.

## Getting started

### Setup
You'll need a few tools before getting started. Ensure you have a recend copy of Xcode downloaded. Then run the following two commands to install `bundler` and the Xcode command-line tools, if you don't have them yet.
```sh
[sudo] gem install bundler
xcode-select --install
```

Then, to download the code, run the following lines. We use some Ruby and Swift dependencies; the following commands ensure they're downloaded and hooked into the Xcode workspace.
```sh
git clone https://github.com/iOS-Capstone/C7FIT.git
cd C7FIT
bundle install
bundle exec pod install
```

### Credentials

To build the project, a few credentials for the services utilized (`Firebase` & `eBay APIs`) are required.

#### Firebase
For Firebase, either follow the instructions [here](https://firebase.google.com/docs/ios/setup) to request a `GoogleService-Info.plist` or request the development credentials from us. Once obtained, add the file to the Xcode project directory under `C7FIT/Supporting Files`. 

#### eBay APIs
For eBay's API services, find the `eBayAPIToken.swift` file and replace `lines 15-18` with credentials from either [here](http://developer.ebay.com/Devzone/rest/ebay-rest/content/creating-edp-account.html) or the development credentials from us.

## Contributing
### Branches
There are two permanent branches: `master` and `dev`.

Other branches should be named in the format: `feature/{issue-number}/{description}`

### Pull-request etiquette
Before making a pull-request, ensure tests are passing locally by running:
```sh
bundle exec fastlane test
```
