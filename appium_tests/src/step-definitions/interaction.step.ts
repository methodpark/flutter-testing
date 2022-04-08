import { defineParameterType, Then, When } from '@cucumber/cucumber';
import * as find from 'appium-flutter-finder';
import { World } from '../types/world';


const textFieldFinder = find.byType('TextField');

defineParameterType({
  name: 'ordinal',
  regexp: /([1-9]*[0-9]+)(st|nd|rd)/,
  transformer: (captured) => parseInt(captured)
})

When('I enter the text {word} to the text field', async function (this: World, itemName: string) {
  await this.driver.elementSendKeys(textFieldFinder, itemName);
});

When('I tap the button labeled {word}', async function (this: World, labelName: string) {
  await this.driver.elementClick(find.byText(labelName));
});

When('I tap the {ordinal} checkbox', async function (this: World, number: number) {
  await this.driver.elementClick(
    find.descendant({
      of: find.byValueKey('Items-Row-' + (number - 1)),
      matching: find.byType('Checkbox'),
    })
  );
});

Then('item {word} is found', async function (this: World, itemName: string) {
  await this.driver.execute('flutter:waitFor', find.byText(itemName));
});

Then('the text {string} is found', async function (this: World, text: string) {
  await this.driver.execute('flutter:waitFor', find.byText(text));
})
