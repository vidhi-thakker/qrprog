FROM python:3.12.0a1-buster
# add a user to run
RUN apt-get update &&\
    /usr/local/bin/python3 -m pip install --upgrade pip &&\
    /usr/local/bin/python3 -m pip install --upgrade setuptools &&\
    adduser myuser
ENV PATH="/home/myuser/.local/bin:${PATH}"
ENV QR_CODE_IMAGE_DIRECTORY="images"
ENV QR_CODE_DEFAULT_URL="https://hub.docker.com/r/kaw393939/qrcode"
ENV QR_CODE_DEFAULT_FILE_NAME="qrcode_project.png"
WORKDIR /home/myuser
COPY --chown=myuser:myuser . .
RUN pip3 install -r requirements.txt
# runs the python program as myuser
ENTRYPOINT ["runuser", "-u", "myuser", "--", "python3"]
CMD ["main.py"]
