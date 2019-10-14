FROM alpine as build

WORKDIR /app

RUN apk add --update alpine-sdk git automake autoconf libtool pkgconfig tree

RUN git clone https://github.com/samhocevar/rinetd.git

RUN	cd rinetd/ && \
	chmod +x ./bootstrap && ./bootstrap && \
	chmod +x ./configure && ./configure && \
	make && tree .

FROM alpine

COPY ./run.sh /run.sh

RUN chmod +x /run.sh

COPY --from=build /app/rinetd/rinetd /usr/bin/rinetd

CMD ["/bin/sh", "-c", "/run.sh"]