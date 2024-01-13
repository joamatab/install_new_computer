
curl -L -O "https://repo.anaconda.com/miniconda/Miniconda3-latest-$(uname)-$(uname -m).sh"

[ ! -d ~/miniconda3 ] && bash Miniconda3-latest-$(uname)-$(uname -m).sh -b
