panic() {
	echo "$1"
	exit 1
}

rand_int() {
	awk "BEGIN{srand();print int($1+rand()*($2-$1+1))}"
}

mk_temp_dir() {
	x=""
	while true; do
		x="/tmp/$(rand_int 0 999999999)"
		if mkdir -m 700 "$x" > /dev/null 2>&1; then
			break
		fi
	done
	echo "$x"
}

check_user() {
	echo "checking user is not 'root'"
	if [ "$LOGNAME" != root ]; then
		return
	fi
	panic "user is 'root'"
}

check_deps() {
	echo "checking deps are installed"
	ok=true
	for x in curl git python unzip; do
		if ! command -v "$x" > /dev/null; then
			echo "'$x' not installed"
			ok=false
		fi
	done
	if $ok; then
		return
	fi
	panic "not all deps are installed"
}

dl_sample_proj() {
	dst='sample-project'
	url="https://github.com/cmugpi/learn-git/raw/master/src/$dst.zip"
	echo "downloading and unzipping '$url' to '$dst'"
	if [ -e "$dst" ] || [ -L "$dst" ]; then
		panic "'$dst' already exists"
	fi
	tmp="$(mk_temp_dir)"
	trap "rm -r '$tmp'" EXIT
	zip="$tmp/$dst.zip"
	curl -fsSLo "$zip" "$url"
	unzip -q -d . "$zip"
}

main() {
	set -eu
	check_user
	check_deps
	dl_sample_proj
	echo "finishing"
}

main
