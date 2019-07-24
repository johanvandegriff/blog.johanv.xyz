#!/bin/sh
sed -i 's,<nav>$,<nav><a class="pinned" href="https://johanv.xyz/">Home</a>,' templates/collection-post.tmpl templates/collection.tmpl
sed -i 's,{{if or .IsOwner .SingleUser}}<nav id="manage"><ul>,{{if or .IsOwner}}<nav id="manage"><ul>,' templates/collection.tmpl