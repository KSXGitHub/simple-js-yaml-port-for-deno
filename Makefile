node_modules: package.json
	pnpm install

js-yaml.min.js: node_modules
	cp node_modules/js-yaml/dist/js-yaml.min.js js-yaml.min.js

js-yaml.d.ts: node_modules
	cp node_modules/@types/js-yaml/index.d.ts js-yaml.d.ts

js-yaml.js: js-yaml.min.js
	deno run generate.js > js-yaml.js

test: js-yaml.js js-yaml.d.ts
	deno test test.ts

tag:
	deno run -A tag.ts
