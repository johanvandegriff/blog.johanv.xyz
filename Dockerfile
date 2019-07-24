FROM writeas/writefreely

COPY config.ini .
COPY patch.sh .

EXPOSE 8080

RUN ["./patch.sh"]
CMD ["bin/writefreely"]
