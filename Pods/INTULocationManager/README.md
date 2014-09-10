# INTULocationManager
INTULocationManager makes it easy to get the device's current location on iOS.

INTULocationManager provides a block-based asynchronous API to request the current location. It internally manages multiple simultaneous location requests, and each request specifies its own desired accuracy level and timeout duration. INTULocationManager automatically starts location services when the first request comes in, and stops location services once all requests have been completed.

## What's wrong with CLLocationManager?
The CLLocationManager API works best when you need to track changes in the user's location over time, such as for turn-by-turn GPS navigation apps. However, requesting one-off location updates is a common task for many apps, such as when you want to autofill an address from the current location, or determine which city the user is currently in. If you just need to ask "Where am I?" every now and then, CLLocationManager is fairly difficult to work with because you must check for and handle a variety of things like user permissions, stale/inaccurate locations, errors, and more.

INTULocationManager makes it easy to request the device's current location, with a simple API that allows you to specify how accurate of a location you need, and how long you're willing to wait to get it. INTULocationManager is power efficient and conserves the user's battery by powering down location services (e.g. GPS) as soon as they are no longer needed.

## Usage

### Requesting Permission to Access Location Services
INTULocationManager automatically handles obtaining permission to access location services when you issue a location request and the user has not already granted your app permission to access location services.

#### iOS 6 & 7
For iOS 6 & 7, it is recommended that you provide a description for how your app uses location services by setting a string for the key [`NSLocationUsageDescription`](https://developer.apple.com/library/ios/documentation/general/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW18) in your app's `Info.plist` file.

#### iOS 8
Starting with iOS 8, you **must** provide a description for how your app uses location services by setting a string for the key [`NSLocationWhenInUseUsageDescription`](https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW26) or [`NSLocationAlwaysUsageDescription`](https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW18) in your app's `Info.plist` file. INTULocationManager determines which level of permissions to request based on which description key is present. You should only request the minimum permission level that your app requires, therefore it is recommended that you use the "When In Use" level unless you require more access. If you provide values for both description keys, the more permissive "Always" level is requested.

### Getting the Current Location
To get the device's current location, use the method `requestLocationWithDesiredAccuracy:timeout:block:`.

The `desiredAccuracy` parameter specifies how **accurate and recent** of a location you need. The possible values are:
```objective-c
INTULocationAccuracyCity          // 5000 meters or better, received within the last 10 minutes  -- lowest accuracy
INTULocationAccuracyNeighborhood  // 1000 meters or better, received within the last 5 minutes
INTULocationAccuracyBlock         // 100 meters or better, received within the last 1 minute
INTULocationAccuracyHouse         // 15 meters or better, received within the last 15 seconds
INTULocationAccuracyRoom          // 5 meters or better, received within the last 5 seconds      -- highest accuracy
```

The `timeout` parameter specifies how long you are willing to wait for a location with the accuracy you requested. The timeout guarantees that your block will execute within this period of time, either with a location of at least the accuracy you requested (`INTULocationStatusSuccess`), or with whatever location could be determined before the timeout interval was up (`INTULocationStatusTimedOut`). Pass `0.0` for no timeout *(not recommended)*.

By default, the timeout countdown begins as soon as the `requestLocationWithDesiredAccuracy:timeout:block:` method is called. However, there is another variant of this method that includes a `delayUntilAuthorized` parameter, which allows you to pass YES to delay the start of the timeout countdown until the user has responded to the system location services permissions prompt (if the user hasn't allowed or denied the app access yet).

Here's an example:
```objective-c
INTULocationManager *locMgr = [INTULocationManager sharedInstance];
[locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                   timeout:10.0
                      delayUntilAuthorized:YES	// This parameter is optional, defaults to NO if omitted
                                     block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                         if (status == INTULocationStatusSuccess) {
                                             // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                                             // currentLocation contains the device's current location.
                                         }
                                         else if (status == INTULocationStatusTimedOut) {
                                             // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                                             // However, currentLocation contains the best location available (if any) as of right now,
                                             // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                                         }
                                         else {
                                             // An error occurred, more info is available by looking at the specific status returned.
                                         }
                                     }];
```

### Managing In-Progress Requests
When issuing a location request, you can optionally store the request ID, which allows you to force complete or cancel the request at any time:
```objective-c
NSInteger requestID = [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse
                                                                                       timeout:5.0
                                                                                         block:locationRequestBlock];

// Force the request to complete early, like a manual timeout (will execute the block)
[[INTULocationManager sharedInstance] forceCompleteLocationRequest:requestID];

// Cancel the request (won't execute the block)
[[INTULocationManager sharedInstance] cancelLocationRequest:requestID];
```

## Example Project
An [example project](https://github.com/intuit/LocationManager/tree/master/LocationManagerExample) is provided. It requires Xcode 5 and iOS 7.0 or later. Please note that it can run in the iOS Simulator, but you need to go to the iOS Simulator's **Debug > Location** menu once running the app to simulate a location (the default is **None**).

## Installation
*INTULocationManager requires iOS 6.0 or later.*

**Using [CocoaPods](http://cocoapods.org)**

1.	Add the pod `INTULocationManager` to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html).

    	pod 'INTULocationManager'

2.	Run `pod install` from Terminal, then open your app's `.xcworkspace` file to launch Xcode.
3.	`#import "INTULocationManager.h"` wherever you want to use it.

**Manually from GitHub**

1.	Download all the files in the [Source directory](https://github.com/intuit/LocationManager/tree/master/Source).
2.	Add all the files to your Xcode project (drag and drop is easiest).
3.	`#import "INTULocationManager.h"` wherever you want to use it.

## Issues & Contributions
Please [open an issue here on GitHub](https://github.com/intuit/LocationManager/issues/new) if you have a problem, suggestion, or other comment.

Pull requests are welcome and encouraged! There are no official guidelines, but please try to be consistent with the existing code style.

## License
INTULocationManager is provided under the MIT license.
