import * as esbuild from 'esbuild';

import { getExecFiles } from './lib.js'

await esbuild.build({
    entryPoints: await getExecFiles(),
    bundle: true,
    outdir: 'dist',
    outbase: 'src',
    format: 'esm',
    logLevel: 'info'
});
