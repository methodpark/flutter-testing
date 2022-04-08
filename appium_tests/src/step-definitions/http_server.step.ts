import { Given } from '@cucumber/cucumber';
import { ADB } from 'appium-adb';
import pause from 'connect-pause';
import { Server } from 'http';
import jsonServer from 'json-server';

let httpServer: Server;

Given(/http-server is started( with delay)?/, async function (delayGroup) {
  const newServer = jsonServer.create();

  if (delayGroup != null) {
    newServer.use(pause(1500));
  }

  const router = jsonServer.router({
    "list": {
      "items": [
        {
          "text": "Create webserver",
          "isChecked": true
        },
        {
          "text": "Load from webserver",
          "isChecked": true
        },
        {
          "text": "Update to webserver",
          "isChecked": false
        }
      ]
    }
  });
  newServer.use(router);

  const middlewares = jsonServer.defaults()
  newServer.use(middlewares)

  httpServer?.close();
  httpServer = newServer.listen(3000);

  const adb = await ADB.createADB();
  adb.reversePort(3000, 3000);
});
