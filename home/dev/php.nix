{ pkgs, ... }:

{
  home.packages = [
    (pkgs.php82.buildEnv {
      extensions = ({enabled, all}: enabled ++ (with all; [
        bcmath
        bz2
        calendar
        dom
        ctype
        curl
        enchant
        exif
        ffi
        fileinfo
        gd
        gettext
        grpc
        iconv
        intl
        imagick
        mbstring
        mongodb
        opcache
        openssl
        pdo_pgsql
        pcntl
        posix
        pspell
        rdkafka
        redis
        session
        shmop
        simplexml
        sockets
        sodium
        sysvmsg
        sysvsem
        sysvshm
        tidy
        tokenizer
        xml
        xmlreader
        xmlwriter
        xsl
        zip
      ]));
    })
  ];
}
