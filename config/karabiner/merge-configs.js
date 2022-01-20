#!/usr/bin/env node

// run this as:
// nodemon --watch ./config/karabiner/karabiner.edn --exec 'clear; goku; sleep 1;./config/karabiner/merge-configs.js'

const { promises: FsPromises } = require("fs");
const Path = require("path");

const CURRENT_DIR = Path.normalize(__dirname);
const GOKU_CONFIG_PATH = Path.join(CURRENT_DIR, "karabiner.json");
const NON_GOKU_CONFIG_PATH = Path.join(CURRENT_DIR, "non-goku-config.json");

const main = async () => {
  const gokuConfig = require(GOKU_CONFIG_PATH);
  const karabinerConfig = require(NON_GOKU_CONFIG_PATH);

  const mergedConfig = Object.assign({}, gokuConfig, karabinerConfig);
  mergedConfig.profiles[0].complex_modifications.rules.push(
    ...gokuConfig.profiles[0].complex_modifications.rules
  );

  await FsPromises.writeFile(
    GOKU_CONFIG_PATH,
    JSON.stringify(mergedConfig, null, 2),
    "utf-8"
  );
};

main();
