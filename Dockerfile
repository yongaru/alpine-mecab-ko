FROM alpine:3.8
LABEL maintainer "Yongaru <akira76@gmail.com>"

# MECAB 버전 및 파일 경로
ENV MECAB_KO_FILENAME "mecab-0.996-ko-0.9.2"
ENV MECAB_KO_URL "https://bitbucket.org/eunjeon/mecab-ko/downloads/$MECAB_KO_FILENAME.tar.gz"

ENV MECAB_KO_DIC_FILENAME "mecab-ko-dic-2.1.1-20180720"
ENV MECAB_KO_DIC_URL "https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/$MECAB_KO_DIC_FILENAME.tar.gz"

RUN apk add --no-cache libstdc++ ;\
    apk --no-cache add --virtual .builddeps build-base autoconf automake ;\
    wget -O - $MECAB_KO_URL | tar zxfv - ;\
    cd $MECAB_KO_FILENAME; ./configure; make; make install ;cd .. ;\
    wget -O - $MECAB_KO_DIC_URL | tar zxfv - ;\
    cd $MECAB_KO_DIC_FILENAME; sh ./autogen.sh ; ./configure; make; make install ; cd ..; \
    apk del .builddeps ;\
    rm -rf mecab-*

# 위 내용을 풀면 아래와 같다.

# # docker run -d --name postgres -e POSTGRES_PASSWORD=postgres binakot/postgresql-postgis-timescaledb
# RUN apk add --no-cache \
#         libstdc++ 

# RUN apk --no-cache add --virtual .builddeps \
#         build-base \
#         autoconf \
#         automake 
# # # Mecab
# RUN wget -O - https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz | tar zxfv -
# RUN cd mecab-0.996-ko-0.9.2; ./configure; make; make install 

# # # Mecab-Ko-Dic
# RUN wget -O - https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz | tar zxfv -
# RUN cd mecab-ko-dic-2.1.1-20180720; sh ./autogen.sh
# RUN cd mecab-ko-dic-2.1.1-20180720; ./configure; make; make install

# # # Cleaning
# RUN  apk del .builddeps
# RUN rm -rf mecab-*

# TEST 방법
# docker mrun -it yongaru/alpine-mecab-ko /usr/local/libexec/mecab
# 실행후 한글을 입력하고 엔터를 쳐본다
# 
# CMD ["mecab"]
