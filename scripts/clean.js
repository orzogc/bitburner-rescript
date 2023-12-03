import { access, constants, readdir, rm, stat, } from 'node:fs/promises';
import { join } from 'node:path';

import { distDir } from './lib.js'

let distExist = false
try {
    await access(distDir, constants.R_OK | constants.W_OK);
    distExist = true;
} catch {
    //
}

if (distExist) {
    if ((await stat(distDir)).isDirectory()) {
        for (const file of await readdir(distDir, { withFileTypes: true })) {
            const path = join(file.path, file.name);
            console.info(`deleting ${path}`);
            await rm(path, { recursive: true });
        }
    } else {
        console.error(`error: '${distDir}' is not a directory`);
    }
}
