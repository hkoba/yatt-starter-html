FROM perl:latest AS builder

WORKDIR /myapp

COPY cpanfile setup.sh .

RUN ./setup.sh

#========================================

FROM perl:latest

WORKDIR /myapp

COPY --from=builder /myapp/local local

COPY .  .

CMD ["perl", "-Msigtrap=die,normal-signals", "-Mlib=./local/lib/perl5", "./local/bin/plackup"]
