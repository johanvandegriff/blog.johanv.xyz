FROM writeas/writefreely

COPY config.ini .
COPY patch.sh .

EXPOSE 8080

CMD ["./patch.sh"]
CMD ["bin/writefreely"]
