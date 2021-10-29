#!/bin/bash
rm -r build/
# change empty lines to // :::: so it wouldn't be removed by tsc
find . -maxdepth 5 -type f -name  "*.ts"  ! -path "*/.git/*" ! -path "*/node_modules/*" | xargs sed -i '' 's/^\r*$/\/\/ ::::/g'; # change empty lines to '// ::::'
# compile .ts to .js
./node_modules/typescript/bin/tsc --listEmittedFiles --noEmit false;
# prettiefy 
./node_modules/.bin/prettier -w "**/*.js";
# give back empty lines
find . -maxdepth 5 -type f -name  "*.ts" -o -name "*.js"  ! -path "*/.git/*" ! -path "*/node_modules/*" | xargs sed -i '' 's/\/\/ :::://g';
#prepend <script> to frontend files ( those .js that are not in top path)
find . -mindepth 2 -maxdepth 5 -type f -name "*.js" ! -path "*/.git/*" ! -path "*/node_modules/*" ! -path "*/server/*" | xargs sed -i '' '1s/^/<script>\n/g' ;
# append </script> to front --||--
find . -mindepth 2 -maxdepth 5 -type f -name "*.js" ! -path "*/.git/*" ! -path "*/node_modules/*" ! -path "*/server/*" | xargs -I{} sh -c 'echo "</script>" >> {}';
#Rename .js -> .html,  but not top dir Code.js and other backend files  
find . -mindepth 2 -maxdepth 5 -type f -name "*.js" ! -path "*/.git/*" ! -path "*/node_modules/*" ! -path "*/server/*" | sed -e 'p;s/js/html/g' | xargs  -n2 mv;
# move files and dirs to build dir ready for clasp push
# todo add exclude tests/
rsync -r  --exclude '.git/' --exclude 'node_modules/' --exclude 'tests/' --include '*.js' --include '*/' --include '*.html' --include 'appsscript.json' --exclude '*' --prune-empty-dirs   . build/
# rm emitted files not in build/ : top .js, all scripts.html not in build, all html in scripts/
# in top folder .js
find .  -type f -name  "*.js"  ! -path "*/build/*" ! -path "*/.git/*" ! -path "*/node_modules/*" -print0 | xargs -0 rm
# scripts.html not in  build/
find .  -type f -name  "scripts.html"  ! -path "*/build/*" ! -path "*/.git/*" ! -path "*/node_modules/*" -print0 | xargs -0 rm
# all .html files in scripts/
find ./scripts/  -type f -name  "*.html"  ! -path "*/build/*" ! -path "*/.git/*" ! -path "*/node_modules/*" -print0 | xargs -0 rm


