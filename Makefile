node_modules: package.json
	pnpm install

js-yaml.min.js: node_modules
	cp node_modules/js-yaml/dist/js-yaml.min.js js-yaml.min.js

js-yaml.d.ts: node_modules
	cp node_modules/@types/js-yaml/index.d.ts js-yaml.d.ts

js-yaml.js: js-yaml.min.js
	deno run --unstable generate.js > js-yaml.js

test: js-yaml.js js-yaml.d.ts
	deno test --allow-read=js-yaml.js --unstable test.ts

tag:
	deno run -A --unstable tag.ts
