import CheapWatch from 'cheap-watch';
import * as esbuild from 'esbuild';

import { buildOptions, filenameRegex, getExecFiles, scriptsDir } from './lib.js'

let ctx;

async function esbuildWatch() {
    if (ctx !== undefined) {
        await ctx.dispose();
    }
    ctx = await esbuild.context({
        entryPoints: await getExecFiles(),
        ...buildOptions
    });
    await ctx.watch();
}

await esbuildWatch();

const watch = new CheapWatch({ dir: scriptsDir });
await watch.init();
watch.on('+', async ({ path, stats, isNew }) => {
    if (isNew && stats.isFile() && filenameRegex.test(path)) {
        await esbuildWatch();
    }
});
watch.on('-', async ({ path, stats }) => {
    if (stats.isFile() && filenameRegex.test(path)) {
        await esbuildWatch();
    }
})
