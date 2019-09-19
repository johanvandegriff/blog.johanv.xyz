#!/bin/sh

#<script src="https://assets.digitalclimatestrike.net/widget.js" async></script>

#add "email me for comments" to the footer of the posts
#<a id="f50d9c68" href="#f50d9c68" onclick="this.innerHTML='&#x202e;'+'moc'+'&#x2e;'+'liamydnav'+'&#x40;'+'nahoj'+'&#x202d;'">[click to show]</a>
#<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
sed -i "s,</nav></footer>,<p>Send comments to my email at <a id=\"f50d9c68\" href=\"#f50d9c68\" onclick=\"this.innerHTML='\&#x202e;'+'moc'+'\&#x2e;'+'liamydnav'+'\&#x40;'+'nahoj'+'\&#x202d;'\">[click to show]</a> with the article name in the subject line.</p>"'<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.<script src="https://assets.digitalclimatestrike.net/widget.js" async></script></nav></footer>,g' templates/collection.tmpl templates/collection-tags.tmpl templates/collection-post.tmpl

#email on main page
sed -i "s,			</nav>,			<p>Send comments to my email at <a id=\"f50d9c68\" href=\"#f50d9c68\" onclick=\"this.innerHTML='\&#x202e;'+'moc'+'\&#x2e;'+'liamydnav'+'\&#x40;'+'nahoj'+'\&#x202d;'\">[click to show]</a>.</p>"'<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.<script src="https://assets.digitalclimatestrike.net/widget.js" async></script></nav>,g' templates/collection.tmpl

#remove top-left menu
sed -i 's,{{if or .IsOwner .SingleUser}}<nav id="manage"><ul>,{{if or .IsOwner}}<nav id="manage"><ul>,' templates/collection.tmpl

#add "Home" to pinned (old)
#sed -i 's,<nav>$,<nav><a class="pinned" href="https://johanv.xyz/">Home</a>,' templates/collection-post.tmpl templates/collection.tmpl

#add "Home" to pinned
sed -i 's,{{range .PinnedPosts}},<a class="pinned" href="https://johanv.xyz/">Home</a>{{range .PinnedPosts}},' templates/collection.tmpl templates/collection-tags.tmpl templates/collection-post.tmpl

#templates/collection-tags.tmpl
#		<header>
#		<h1 dir="{{.Direction}}" id="blog-title"><a href="{{if .IsTopLevel}}/{{else}}/{{.Collection.Alias}}/{{end}}" class="h-card p-author">{{.Collection.DisplayTitle}}</a></h1>
#			<nav>
#				{{if .PinnedPosts}}
#				{{range .PinnedPosts}}<a class="pinned" href="{{if not $.SingleUser}}/{{$.Collection.Alias}}/{{.Slug.String}}{{else}}{{.CanonicalURL}}{{end}}">{{.DisplayTitle}}</a>{{end}}
#				{{end}}
#			</nav>
#		</header>

#templates/collection.tmpl
#		{{if .PinnedPosts}}<nav>
#			{{range .PinnedPosts}}<a class="pinned" href="{{if not $.SingleUser}}/{{$.Alias}}/{{.Slug.String}}{{else}}{{.CanonicalURL}}{{end}}">{{.PlainDisplayTitle}}</a>{{end}}</nav>
#		{{end}}

#<a class="pinned" href="https://johanv.xyz/">Home</a>
