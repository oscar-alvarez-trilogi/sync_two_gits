#echo "$@" #Descomentar per si es vol veure per terminal les instruccions
set -x

cd amz/
git pull

cd ../*repo*/
cd "../amz/"

if [[ "$*" == *"git push"* ]]; then
	echo "[Github] Aquesta branca només es puja a GitHub"
	echo "[AMAZON] I ara es puja a pre"
	## Aqui caldrà fer un merge d'aquesta branca a "pre"
	cd ../*repo*/	
	"$@"
	cd ../amz/	
	git add .
	git status
	git push origin pre
elif [[ "$*" == *"git add ."* ]]; then
	cd ../*repo*/
	git add .
elif [[ "$*" == *"git commit"* ]]; then
	echo "[Github] Aquest commit es nomes per GitHub"
	cd ../*repo*/
	FILES=$(git diff --name-only HEAD)
	for file in $FILES; do
		echo "$file"
	  	mkdir -p "../amz/$(dirname "$file")"
	  	cp "$file" "../amz/$file"
	done
	git add .
	"$@" # commit dins repo github
	# En aquest punt, ja s'han afegit els fitxers
	cd ../amz/
	git pull
	git add .
	# El que es fara es fer-ho quan es fagi el push
	git commit -m "[sync] $(printf "%s " "$@")"
else
	"$@"
fi