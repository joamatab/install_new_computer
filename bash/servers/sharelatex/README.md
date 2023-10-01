# Install

```
git clone https://github.com/sharelatex/sharelatex
cd sharelatex
docker-compose up -d
```

# Update

docker exec -i -t sharelatex /bin/bash
apt-get update
apt install -y texlive tpt install -y texlive texlive-latex-extra texlive-base texlive-fonts-extra texlive-fulexlive-latex-extra texlive-base texlive-fonts-extra texlive-full
apt install -y texlive
apt-get install -y texlive-latex-extra
apt install -y texlive-base
apt-get install -y texlive-fonts-extra
apt-get install -y texlive-full

# use old packages

tlmgr option repository ftp://tug.org/historic/systems/texlive/2017/tlnet-final
tlmgr update --self --all
tlmgr install scheme-full


References:

- https://tug.org/texlive/upgrade.html
- https://github.com/sharelatex/sharelatex/wiki/Quick-Start-Guide
