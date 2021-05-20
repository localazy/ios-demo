#  Localazy iOS and macOS demo

## Setup

### Configuration file

Adjust properties in the `Localazy.plist` configuration file to adjust Localazy SDK functionality. Especially set your `readKey` to be able to use the SDK with your Localazy project.

For more information please check [documentation in Localazy SDK repository.](https://github.com/localazy/localazy-ios-library)

### Signing

If you want to run this demo App on the real iOS device please set up your Team and bundle identifier in `Signing & Capabilities` section in project file.

### Strings upload

Adjust `Upload strings to Localazy` Run Script Phase in Build Phases to upload or not to upload strings you want to Localazy servers on each app build.
[For more info check documentation for Localazy CLI.](https://localazy.com/docs/cli/)

Change properties in `localazy.json` to reference to your project and to upload your `.strings` files.
[For more info check Uload Reference for Localazy CLI.](https://localazy.com/docs/cli/upload-reference)
