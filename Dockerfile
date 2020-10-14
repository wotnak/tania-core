# build frontend
FROM node:10 as node

WORKDIR /go/src/app
ADD . /go/src/app

RUN cp conf.json.example conf.json && yarn && yarn prod

# build backend
FROM golang:1.15-buster AS build

COPY --from=node /go /go
WORKDIR /go/src/app

RUN go get
RUN go build

# prepare final image
FROM gcr.io/distroless/base-debian10

COPY --from=build /go/src/app/tania-core /app/tania-core
COPY --from=build /go/src/app/conf.json /app/conf.json
COPY --from=build /go/src/app/db/ /app/db/
COPY --from=build /go/src/app/public/ /app/public/
COPY --from=build /go/src/app/uploads/ /app/uploads/

WORKDIR /app

CMD ["/app/tania-core"]
