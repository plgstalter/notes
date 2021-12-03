mkdir $1
cd $1

z='from sys import argv
\nfr_months = {1: "janvier", 2: "février", 3: "mars", 4: "avril", 5: "mai", 6: "juin", 7: "juillet", 8: "août", 9: "septembre", 10: "octobre", 11: "novembre", 12: "décembre"}
\nen_months= {1: "January", 2: "February", 3: "March", 4: "April", 5: "May", 6: "June", 7: "July", 8: "August", 9: "September", 10: "October", 11: "November", 12: "December"}
\nit_months = {1: "gennaio", 2: "febbraio", 3: "marzo", 4: "aprile", 5: "maggio", 6: "giugno", 7: "luglio", 8: "agosto", 9: "settembre", 10: "ottobre", 11: "novembre", 12: "dicembre"}'

echo $z >> nice_date.py
echo "
def nice_date(date: str, language: int):
    '''
    give a date like '2021-12-03' and a language '1', return the date nicely in the required language. Here '3 décembre 2021'
    1: français
    2: english
    3: italiano
    '''" >> nice_date.py
echo '
    if  date[8] == "0":
        day = date[9]
    else:
        day = date[8:]

    if  language == 1:
        return date[8:] + " " + fr_months[int(date[5:7])] + " " + date[:4]
    elif language == 2:
        if int(day)%10 == 1:
	    day += "st"
	elif int(day)%10 == 2:
  	    day += "nd"
	elif int(day)%10 == 3:
	    day += "rd"
	return date[8:] + " " + en_months[int(date[5:7])] + " " + date[:4]
    elif language == 3:
        return date[8:] + " " + it_months[int(date[5:7])] + " " + date[:4]

if  __name__ == "__main__":
    if len(argv) < 2:
        print("No!")
    elif len(argv) == 2:
        print(nice_date(argv[1], 1))
    elif len(argv) > 2:
        print(nice_date(argv[1], int(argv[2])))
' >> nice_date.py

echo 'for dir in "$@"; do
mkdir $dir $dir/src $dir/source $dir/output
echo 2 >> $dir/language.txt

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

echo 'if [ -f `date "+%d_%m"`.md ]; then
	echo "le fichier existe déjà"
else
	echo "---" 		 > `date "+%d_%m"`.md 
	cat info.txt 		>> `date "+%d_%m"`.md
	x=`date "+%Y_%m_%d"`
	y=`cat language.txt`
	echo "date: "`python ../nice_date.py $x $y`  >> `date "+%d_%m"`.md
	echo "header-includes:" >> `date "+%d_%m"`.md
	cat ../header-includes.txt >> `date "+%d_%m"`.md
	echo "---" 		>> `date "+%d_%m"`.md
fi

vim `date "+%d_%m"`.md' >> newfile.sh

echo 'python src/run.py `date "+%d_%m"` ; open `date "+%d_%m"`.pdf' >> run_last.sh
