# C7FIT

### Meta
- State: development
- Point people: 
[@brandonlee503](https://github.com/brandonlee503), 
[@rutgerfarry](https://github.com/rutgerfarry), 
[@willmichael](https://github.com/willmichael)
- CI: [![Build Status](https://travis-ci.org/iOS-Capstone/C7FIT.svg?branch=dev)](https://travis-ci.org/iOS-Capstone/C7FIT)

## Introduction
A fitness app allowing customers of [Club Seven Fitness](http://www.clubsevenfitness.com/) to track their workouts and purchase fitness equipment.

[Rutger Farry](https://github.com/rutgerfarry), [Brandon Lee](https://github.com/brandonlee503), and [Michael Lee's](https://github.com/willmichael) senior project at Oregon State University.

## Getting started
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

## Contributing
### Branches
There are two permanent branches: `master` and `dev`.

Other branches should be named in the format: `feature/{issue-number}/{description}`

### Pull-request etiquette
Before making a pull-request, ensure tests are passing locally by running:
```sh
bundle exec fastlane test
```
