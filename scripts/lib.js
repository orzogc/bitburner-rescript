import { readdir } from 'node:fs/promises';
import { join } from 'node:path';

export async function getExecFiles() {
    return (await readdir('src/scripts/exec', { withFileTypes: true, recursive: true }))
        .filter(f => f.isFile() && /(.+\.js)|(.+\.mjs)|(.+\.cjs)/.test(f.name))
        .map(f => join(f.path, f.name));
}
