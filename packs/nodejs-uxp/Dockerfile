FROM registry.misys.global.ad/solint/nodejs-ubuntu:10

ENV APPDIR="/opt/app"
ARG LOCALAPPFOLDER
ARG BOARDSFOLDER

COPY --chown=swuser:swuser "$LOCALAPPFOLDER/conf.json" "$APPDIR/"
COPY --chown=swuser:swuser "$LOCALAPPFOLDER/mb-package.json" "$APPDIR/"
COPY --chown=swuser:swuser "$LOCALAPPFOLDER/addons" "$APPDIR/addons"
COPY --chown=swuser:swuser "$LOCALAPPFOLDER/node_modules" "$APPDIR/node_modules"
COPY --chown=swuser:swuser "$LOCALAPPFOLDER/model" "$APPDIR/model"
COPY --chown=swuser:swuser "$LOCALAPPFOLDER/ssl" "$APPDIR/ssl"
COPY --chown=swuser:swuser "$BOARDSFOLDER" "$APPDIR/model/_default"

WORKDIR $APPDIR

CMD ["node_modules/.bin/uxp", "-c", "conf.json"]