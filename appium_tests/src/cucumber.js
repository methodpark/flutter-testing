let common = [
  'features/*.feature',                // Specify our feature files
  '--require-module ts-node/register',    // Load TypeScript module
  '--require step-definitions/*.step.ts',   // Load step definitions
  `--format-options '{"snippetInterface": "synchronous"}'`
].join(' ');

module.exports = {
  default: common
};
