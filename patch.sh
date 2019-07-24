#!/bin/sh
sed -i 's,<nav>$,<nav><a class="pinned" href="https://johanv.xyz/">Home</a>,' templates/collection-post.tmpl templates/collection.tmpl
