#echo "$@" 	#Descomentar per si es vol veure per terminal les instruccions
#set -x		#Descomentar per veure les instruccions
cd amz/
git pull

cd ../*repo*/
cd "../amz/"

if [[ "$*" == *"git push"* ]]; then
	#set -x
	echo "[Github] Aquesta branca només es puja a GitHub"
	#echo "[AMAZON] I ara es puja a pre"
	## Aqui caldrà fer un merge d'aquesta branca a "pre"
	cd ../*repo*/	
	BRANCH="$(git rev-parse --abbrev-ref HEAD)"
	if [[ "$BRANCH" == "main" ]]; then
		"$@"
		cd ../amz/	
		git add .
		git status
		git push origin pre # amz pre
	else
		git pull origin $BRANCH
		"$@"
	fi

elif [[ "$*" == *"git add ."* ]]; then
	cd ../*repo*/
	git add .
elif [[ "$*" == *"git merge "* ]]; then
	#set -x
	cd ../*repo*/
	git checkout main # github main
	"$@"

elif [[ "$*" == *"git commit"* ]]; then
	set -x
	echo "[Github] Aquest commit es nomes per GitHub"
	cd ../*repo*/ || exit 1

	# Stage all local changes
	git add -A

	BRANCH="$(git rev-parse --abbrev-ref HEAD)"
	if [[ "$BRANCH" == "main" ]]; then

		# Detect changes with status (Added, Modified, Deleted, Renamed, etc.)
		#FILES=$(git diff --name-status HEAD)
		FILES=$(git diff --name-status HEAD~1 HEAD)

		while IFS=$'\t' read -r status file newfile; do
		    echo "$status $file $newfile"

		    case "$status" in
		        A|M) # Added or Modified
		            mkdir -p "../amz/$(dirname "$file")"
		            cp "$file" "../amz/$file"
		            ;;
		        D) # Deleted
		            rm -f "../amz/$file"
		            ;;
		        R*) # Renamed (old -> new)
		            rm -f "../amz/$file"
		            mkdir -p "../amz/$(dirname "$newfile")"
		            cp "$newfile" "../amz/$newfile"
		            ;;
		        *) # Catch-all (just in case)
		            echo "Unhandled status: $status $file $newfile"
		            ;;
		    esac
		done <<< "$FILES"

		"$@" # commit dins repo github

		# Sync into the amz repo
		cd ../amz/
		git pull
		git add -A   # ensures deletions/renames are staged properly
		msg="${@: -1}"   # last argument (works on bash)
		git commit -m "[sync] $msg"

	else
		"$@" # commit dins repo github
	fi

elif [[ "$*" == *"sync"* ]]; then
	set -x
	cd ../amz/
	git pull
	cd ..

	SRC_DIR="$2"
	DST_DIR="$3"
	rsync -av --update --exclude=".git" "$SRC_DIR" "$DST_DIR"

	#Ara farem els commmit dels canvis de repo que vinguin derivats de amz
	cd *repo*/
	
	BRANCH="$(git rev-parse --abbrev-ref HEAD)"
	if [[ "$BRANCH" == "main" ]]; then
		git add -A
		git commit -m "[sync] pre amz --> main github"
		git push origin main
	else
		echo 'La branca del repo no es main!'
		return
	fi

elif [[ "$*" == *"git status"* ]]; then
	cd ../*repo*/
	echo 'Git status del repo'
	git status
	cd ../amz
	echo 'Git status de Amazon'
	git status
else
	"$@"
fi