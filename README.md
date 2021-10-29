# Google Apps Script with Typescript starter

### (For reference) Typescript bash based build process - buildGAS.sh
**not intendet to run bc it will remove jest.config.js and removeExport.js in current version**
This script is added as a reference to new custom compiler.
This script follow convention that all .ts files with a name `scripts.ts` and and all files in `/scripts` folder are treated as client files for web app and are transpiled to js, wrapped in <script> tags and changed to `.html`, while all others: files in top folder and files in `server/` folder are treated as backend files and are transpiled to `.js`. (After `clasp push` those files appear in GAS editor as `.gs` files)
Note: `//:::` string is used as replacement of empty lines to block `tsc` from removing them. This workaround with prettier produces output code as sililar as possible to input source files

Sidenote: `clasp` allows to work with `.ts` files for backend but it uses transpilation without any control ( through internal ts2gas package) and output is formatted differently ( no blank lines, 4 spaces indendation)

### Requirments
Clasp is a tool to push script files to GAS.
Install `clasp` globally as recommended 
```
npm install -g clasp
```

Change scriptId in `.clasp.json` to your script
