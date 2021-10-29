const fs = require('fs')
const path = require('path')
const mkdirp = require('mkdirp');
const tsconfig = require('./tsconfig.json')

const finalPath = './transformedFunctions'

const removeExport = (filePath, name) => {

fs.readFile(filePath, 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  var result = data.replace(/export/g, '');

  fs.writeFile(`${finalPath}/${name}`, result, 'utf8', function (err) {
     if (err) return console.log(err);
  });
});
}

const getCurrentFiles = (dir) => {
    const absoluteDir = `${path.join(process.cwd(), '/', dir)}`;
    return fs
      .readdirSync(absoluteDir)
      .reduce((list, name) => {
        const absolutePath = path.join(absoluteDir, name);
        const isDir = fs.statSync(absolutePath).isDirectory();
        return list.concat(isDir ? [] : [{ path: absolutePath, name: name }]);
      }, []);
  };

const checkIfOutDirExists = (dir) => {
    if (!fs.existsSync(dir)) {
      mkdirp.sync(dir);
    }
  };

checkIfOutDirExists(finalPath);

const files = getCurrentFiles(tsconfig.compilerOptions.outDir)

files.forEach(file => {
  removeExport(file.path, file.name)
})