import { readdir } from 'node:fs/promises';
import { join } from 'node:path';

export const dir = 'src/scripts/exec';

export const filenameRegex = /(.+\.js)|(.+\.mjs)|(.+\.cjs)/;

export const buildOptions = {
    bundle: true,
    outdir: 'dist',
    outbase: 'src',
    format: 'esm',
    logLevel: 'info'
}

export async function getExecFiles() {
    return (await readdir(dir, { withFileTypes: true, recursive: true }))
        .filter(f => f.isFile() && filenameRegex.test(f.name))
        .map(f => join(f.path, f.name));
}
