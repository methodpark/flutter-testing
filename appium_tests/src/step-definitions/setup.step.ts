import { Given } from '@cucumber/cucumber';
import * as find from 'appium-flutter-finder';
import * as wdio from 'webdriverio';
import { World } from '../types/world';


const osSpecificOps = process.env.APPIUM_OS === 'android' ? {
    platformName: 'Android',
    deviceName: 'N0AA002186K42207883',
    app: __dirname + '/../../../bloc_pattern_sample_app/build/app/outputs/flutter-apk/app-debug.apk',
} : {};

const opts = {
    path: '/wd/hub',
    port: 4723,
    capabilities: {
        ...osSpecificOps,
        automationName: 'Flutter'
    }
};

Given('the app has started', { timeout: 60 * 1000 }, async function (this: World) {
    this.driver = await wdio.remote(opts);
});

Given('spinner has disappeared', { timeout: 60 * 1000 }, async function (this: World) {
    await this.driver.execute('flutter:waitForAbsent', find.byType('CircularProgressIndicator'));
})
