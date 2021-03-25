docker build . -t coucou
docker run -ti --rm -p 80:80 -p 443:443 --name=coucou coucou