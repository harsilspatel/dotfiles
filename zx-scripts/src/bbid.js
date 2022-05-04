#!/usr/bin/env zx

import * as zx from 'zx';
import parseBitbucketUrl from 'parse-bitbucket-url';

async function main() {
  try {
    const gitOrigin = process.argv[2] || (await zx.$`git config --get remote.origin.url`).stdout.trim();
    const parsedUrl = parseBitbucketUrl(gitOrigin);
    const repoResponse = JSON.parse(
      (
        await zx.quiet(
          zx.$`curl -H "Authorization: $(atlas slauth oauth -s team -a bitbucket.org -o http)" -s "https://bitbucket.org/!api/2.0/repositories/${parsedUrl.repository}"`
        )
      ).stdout
    );
    console.log(`bitbucket-pipelines:${repoResponse.workspace.uuid}:${repoResponse.uuid}`);
  } catch (p) {
    console.error(`Exit code: ${p.exitCode}`);
    console.error(`Error: ${p.stderr}`);
  }
}

main();
