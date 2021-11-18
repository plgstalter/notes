mkdir $1
cd $1

echo 'for dir in "$@"; do
mkdir $dir $dir/src $dir/source $dir/output

echo "mv *.md source
mv *.pdf output" >> $dir/src/orga.py

echo "import os
from sys import argv

if len(argv)<2:
    raise AttributeError(rentrez le document demandé svp)
else:
    os.system(pandoc -o {}.pdf {}.md.format(argv[1], argv[1]))" >> $dir/src/run.py
echo "title: 
author: " >> $dir/info.txt
done' >> newdir.sh

echo ' - \usepackage{amsmath}
 - \usepackage{stmaryrd}' > header-includes.txt
printf %s ' - \' >> header-includes.txt  
echo "newcommand{\dsum}{\displaystyle\sum}" >> header-includes.txt
printf %s ' - \' >> header-includes.txt
echo "newcommand{\R}{\mathbb R}" >> header-includes.txt
printf %s ' - \' >> header-includes.txt
echo "newcommand{\N}{\mathbb N}" >> header-includes.txt
printf %s ' - \' >> header-includes.txt
printf %s 'newcommand{\lrb}[1]{\llbracket{#1}\' >> header-includes.txt
echo "rrbracket}" >> header-includes.txt
printf %s ' - \' >> header-includes.txt
printf %s 'newcommand{\ens}[1]{\left\{{#1}\' >> header-includes.txt
echo "right\}}" >> header-includes.txt

echo 'if [ -f `date "+%d_%m"`.md ]; then
	echo "le fichier existe déjà"
else
	echo "---" 		 > `date "+%d_%m"`.md 
	cat info.txt 		>> `date "+%d_%m"`.md
	date "+date: %Y-%m-%d"  >> `date "+%d_%m"`.md
	echo "header-includes:" >> `date "+%d_%m"`.md
	cat ../header-includes.txt >> `date "+%d_%m"`.md
	echo "---" 		>> `date "+%d_%m"`.md
fi

vim `date "+%d_%m"`.md' >> newfile.sh

echo 'python src/run.py `date "+%d_%m"` ; open `date "+%d_%m"`.pdf' >> run_last.sh
