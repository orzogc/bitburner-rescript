import { readdir, rm } from 'node:fs/promises';
import { join } from 'node:path';

for (const file of await readdir('dist', { withFileTypes: true })) {
    const path = join(file.path, file.name);
    console.info(`deleting ${path}`);
    await rm(path, { recursive: true });
}
