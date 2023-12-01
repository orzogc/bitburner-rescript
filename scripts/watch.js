import * as esbuild from 'esbuild';

import { getExecFiles } from './lib.js'

let ctx = await esbuild.context({
    entryPoints: await getExecFiles(),
    bundle: true,
    outdir: 'dist',
    outbase: 'src',
    format: 'esm',
    logLevel: 'info'
});

await ctx.watch();
