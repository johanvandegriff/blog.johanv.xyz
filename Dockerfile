FROM writeas/writefreely

COPY config.ini .

EXPOSE 8080

CMD sed -i 's,<nav>$,<nav><a class="pinned" href="https://johanv.xyz/">Home</a>,' /go/templates/collection-post.tmpl /go/templates/collection.tmpl
CMD ["bin/writefreely"]
