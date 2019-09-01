#!/bin/sh
#add "email me for comments" to the footer of the posts
#<a id="f50d9c68" href="#f50d9c68" onclick="this.innerHTML='&#x202e;'+'moc'+'&#x2e;'+'liamydnav'+'&#x40;'+'nahoj'+'&#x202d;'">[click to show]</a>
sed -i "s,</nav></footer>,<p>Send comments to my email at <a id=\"f50d9c68\" href=\"#f50d9c68\" onclick=\"this.innerHTML='\&#x202e;'+'moc'+'\&#x2e;'+'liamydnav'+'\&#x40;'+'nahoj'+'\&#x202d;'\">[click to show]</a> with the article name in the subject line.</p></nav></footer>,g" templates/collection.tmpl templates/collection-tags.tmpl templates/collection-post.tmpl

#email on main page
sed -i "s,			</nav>,			<p>Send comments to my email at <a id=\"f50d9c68\" href=\"#f50d9c68\" onclick=\"this.innerHTML='\&#x202e;'+'moc'+'\&#x2e;'+'liamydnav'+'\&#x40;'+'nahoj'+'\&#x202d;'\">[click to show]</a>.</p></nav>,g" templates/collection.tmpl

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




