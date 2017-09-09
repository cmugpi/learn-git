panic() {
	echo "$1"
	exit 1
}

rand_int() {
	awk -v lo=$1 -v hi=$2 'BEGIN{srand();print int(lo+rand()*(hi-lo+1))}'
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
	if [ "$USER" != root ]; then
		return
	fi
	panic "user is 'root'"
}

check_deps() {
	echo "checking deps are installed"
	ok=true
	for x in curl python git zip; do
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
	echo "downloading '$dst'"
	if [ -e "$dst" ] || [ -L "$dst" ]; then
		panic "'$dst' already exists"
	fi
	url="https://github.com/cmugpi/learn-git/raw/master/src/$dst.zip"
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
