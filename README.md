# SNAKE-RX
This project is a URL scanner using Google Dorking, derived from FGDS.sh and still being improved. Powerd by [searx.work API](https://searx.work/)

Usage example:
--------------
```
chmod +x snake2x.sh
./snake2x.sh one.one.one.one
```
or
```
./snake2x.sh one.one.one.one
```

It did not work with Docker in our environment, but we have fixed it.
```
docker build -t foo .
```
it run it with your argument for the URL such as this:
```
docker run -it --rm foo mysite.com
```

