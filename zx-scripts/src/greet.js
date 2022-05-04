#!/usr/bin/env zx

import * as zx from "zx";

zx.$.verbose = (process.env.ZX_VERBOSE || "").toLowerCase() === "true";

async function main() {
  try {
    // console.log("zx.$.verbose", zx.$.verbose);
    // console.log((await zx.$`exit 1`).stdout);
    console.log((await zx.$`date`).stdout);
    console.log((await zx.$`echo "hello"`).stdout);
  } catch (p) {
    console.error(`Exit code: ${p.exitCode}`);
    console.error(`Error: ${p.stderr}`);
  }
}

main();
