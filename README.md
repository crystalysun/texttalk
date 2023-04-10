### TextTalk

## To install and use:

- XCode is **required** to run the application (if you don't have XCode, please email someone else in the group to use their simulator, or meet with a TextTalk team member!)
- Install [CocoaPods](https://cocoapods.org/) in XCode
- Run `pod install` in the proper directory containing your Podfile
- Open `TextTalk.xcworkspace` file to build the project

## Running the App on iPhone:

- Open `TextTalk.xcworkspace` file
- Plug phone into laptop
- Click play button to build
- There is a chance that the iOS version on your phone may not be compatible with the project. If so, we recommend using the simulator instead.

### Possible Pitfalls
- If asks for access, go to iPhone Settings -> VPN & Device Management to allow the developer
- If asks for developer mode, go to iPhone Settings -> Privacy and Security -> Developer Mode, and restart your device.
- If the development team or profile doesn't work, set the development team to your personal team, and rename the bundle identifier to something unique


## Running the App on XCode Simulator:

- Open `TextTalk.xcworkspace` file
- Choose a later iPhone device to run on (iPhone 14 Pro recommended)
- In order to use Text to Speech, you must download the voices onto the simulated phone. To do this, navigate to iPhone Settings -> Accessibility -> Spoken Content -> Voices and download the desired voices.

## Bugs
- You may experience issues using switching from Speech-to-Text to Text-To-Speech. If so, begin testing from Text-To-Speech.
- The signaling server is not properly configurated yet, so calls may not reach the other user. 

## Sources
- Saved Phrases database inspired by [this list of commonly used telephone phrases](https://www.englishclub.com/speaking/telephone-phrases.php)
