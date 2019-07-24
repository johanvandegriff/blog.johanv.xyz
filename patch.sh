#!/bin/sh
sed -i 's,<nav>$,<nav><a class="pinned" href="https://johanv.xyz/">Home</a>,' templates/collection-post.tmpl templates/collection.tmpl
ls >> $0
pwd >> $0
echo >> $0
find >> $0