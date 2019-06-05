FROM python:3.7-alpine

RUN mkdir /opt/app
WORKDIR /opt/app

COPY ./ /opt/app
RUN pip install -e .

