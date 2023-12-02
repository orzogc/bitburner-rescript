import * as esbuild from 'esbuild';

import { buildOptions, getExecFiles } from './lib.js'

await esbuild.build({
    entryPoints: await getExecFiles(),
    ...buildOptions
});
