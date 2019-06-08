FROM writeas/writefreely

COPY config.ini .

EXPOSE 8080

CMD ["bin/writefreely"]
