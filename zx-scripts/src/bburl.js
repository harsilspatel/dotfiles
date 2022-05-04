#!/usr/bin/env zx

import * as zx from 'zx';
import axios from 'axios';

zx.$.verbose = (process.env.ZX_VERBOSE || '').toLowerCase() === 'true';

async function main() {
  try {
    const bbId = process.argv[2];
    const allIds = bbId.split(':');
    const workspaceId = allIds[1];
    const repositoryId = allIds[2];

    const auth = (await zx.$`atlas slauth oauth -s team -a bitbucket.org -o http`).stdout.trim();
    const url = `https://bitbucket.org/!api/2.0/repositories/${workspaceId}/${repositoryId}`;

    // $`curl ...` doesn't work because when using string templates, zx escapes strings and that cases issues
    const repoResponse = await axios({ method: 'GET', url, headers: { Authorization: auth } });
    console.log(repoResponse.data.links.html.href);
  } catch (p) {
    console.error(`Exit code: ${p.exitCode}`);
    console.error(`Error: ${p.stderr}`);
  }
}

main();
