FROM writeas/writefreely

COPY config.ini .
COPY patch.sh .

EXPOSE 8080

CMD ["bin/writefreely"]
CMD ["./patch.sh"]
