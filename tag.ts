import { assert } from 'https://deno.land/std@0.51.0/testing/asserts.ts'
import { resolve } from 'https://deno.land/std@0.51.0/path/mod.ts'
import { readJsonSync } from 'https://deno.land/std@0.51.0/fs/mod.ts'
import { dirname } from 'https://deno.land/x/dirname/mod.ts'
import { pipe } from 'https://deno.land/x/compose@1.3.2/index.js'

const pkgJson: any = pipe(
  import.meta,
  dirname,
  x => resolve(x, 'package.json'),
  readJsonSync,
)

assert(typeof pkgJson === 'object', 'package.json must be an object')
assert(pkgJson, 'package.json must not be null')
assert(typeof pkgJson.version === 'string', 'package.json#version must be a string')

Deno.run({
  cmd: ['git', 'tag', pkgJson.version],
  stdout: 'inherit',
  stderr: 'inherit',
  stdin: 'inherit'
})
