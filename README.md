## 生成镜像

脚本没有执行权限

```
git update-index --chmod=+x run.sh
```



```bash
docker build -t yaokun/php-nginx:7-alpine .
```

> 需要注意文件格式，应为unix格式，脚本文件需要有执行权限。
>

## 扩展说明

官方版本默认安装扩展：

```
Core, ctype, curl
date, dom
fileinfo, filter, ftp
hash
iconv
json
libxml
mbstring, mysqlnd
openssl
pcre, PDO, pdo_sqlite, Phar, posix
readline, Reflection, session, SimpleXML, sodium, SPL, sqlite3, standard
tokenizer
xml, xmlreader, xmlwriter
zlib
```

添加扩展参考 https://github.com/mlocati/docker-php-extension-installer

## 运行镜像

```bash
docker run -d \
-p 80:80 \
yaokun/php-nginx:7-alpine
```

