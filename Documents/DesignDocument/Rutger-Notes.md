# Rutger's Design Doc Notes

## Parsing Mindbody Data
This will be done using Apple's XMLParser library. We will likely want to wrap this so we can easily parse Mindbody responses into Swift structs. Below are a few links that will help with implementation:
- [Documentation](https://developer.apple.com/reference/foundation/xmlparser) - Apple's documentation on XMLParser
- [SeismicXML](https://developer.apple.com/library/content/samplecode/SeismicXML/Introduction/Intro.html) - A sample app built by Apple showing how to use the XMLParser library on seismic data

## Handling Touch Events
We will handle most ( > 90%) of touch events using the gesture recognizers built into UIKit components. The rest of the time, we will place gesture recognizers on our custom objects.
- [UIKit Documentation](https://developer.apple.com/reference/uikit) - Apple's UIKit documentation
- [Gesture Recognizers](https://developer.apple.com/library/content/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/GestureRecognizer_basics/GestureRecognizer_basics.html) - Apple reference for using gesture recognizers
- [UIGestureRecognizer Tutorial](https://www.raywenderlich.com/104744/uigesturerecognizer-tutorial-creating-custom-recognizers) - A tutorial by Ray Wenderlich on how to create custom gesture recognizers

## Storing / Modifying Application State
To store application state, we are hoping to use a single state container that is injected into each view. The view will then transform the data in the container into something the user can digest. This is inspired by Facebook's Flux data flow and the Redux library.
- [Advanced iOS Application Architecture and Patterns](https://developer.apple.com/videos/play/wwdc2014/229/) - A talk by ex-Apple engineer Andy Matuschak at the WWDC conference about managing application state
- [Command Query Responsibility Segregation](http://martinfowler.com/bliki/CQRS.html) - Article about formalizing how to interact with your app's datastore
- [Redux Motivation](http://redux.js.org/docs/introduction/Motivation.html) - The creator of Redux talks about the motivation behind creating the library
