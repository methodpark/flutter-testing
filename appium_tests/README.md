# How to run appium cucumber tests

### Structure
Be aware that, regardless of the directory structure employed, Cucumber effectively flattens the `features/` directory tree when running tests. This means that anything ending in `.js` inside the directory in which Cucumber is run is treated as a step definition. In the same directory, Cucumber will search for a `Feature` corresponding to that step definition. This is either the default case or the location specified with the relevant option.

### Install appium
`npm install -g appium`

### Init project
`npm install` (inside src folder)

### Start appium
`appium`

### Start cucumber tests 
`npm test` (inside src folder)
`APPIUM_OS=android npm test` (if no platformName capability is set)


### Cucumber documentation
Tutorial: https://cucumber.io/docs/guides/10-minute-tutorial/

### Troubleshooting
- Sometimes the test failed because elementSendKeys seems to work but the keys didn't appear in the input field. --> A reabuild seems to solve the problem
