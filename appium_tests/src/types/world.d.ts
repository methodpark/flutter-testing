import { World as CucumberWorld } from '@cucumber/cucumber';
import type WebdriverIO from "webdriverio";


export type World = CucumberWorld & { driver: WebdriverIO.Browser<"async"> };
