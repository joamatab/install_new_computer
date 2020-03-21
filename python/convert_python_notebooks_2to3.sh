
for i in  *.ipynb; do
    echo $i
    ./ipy2to3.py $i ./py3/$i
done
