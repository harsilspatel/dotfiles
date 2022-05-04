#!/usr/bin/env zx

import * as zx from 'zx';
import open from 'open';
import parseBitbucketUrl from 'parse-bitbucket-url';

zx.$.verbose = (process.env.ZX_VERBOSE || '').toLowerCase() === 'true';

async function main() {
  try {
    const gitOrigin = (await zx.$`git config --get remote.origin.url`).stdout.trim();
    const parsedUrl = parseBitbucketUrl(gitOrigin);

    const currentBranch = (await zx.$`git branch --show-current`).stdout.trim();
    const pullRequestUrl = `https://${parsedUrl.host}/${parsedUrl.owner}/${parsedUrl.name}/pull-requests/new?source=${currentBranch}`;

    await open(pullRequestUrl);
  } catch (p) {
    console.error(`Exit code: ${p.exitCode}`);
    console.error(`Error: ${p.stderr}`);
  }
}

main();
