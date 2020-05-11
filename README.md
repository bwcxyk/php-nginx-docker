## 生成镜像
```bash
docker build -t yaokun/php7-nginx:1.0-alpine .
```




## 运行镜像
```bash
docker run -d -p 80:80 yaokun/php7-nginx:1.0-alpine
```

