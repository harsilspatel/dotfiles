function commit_file() {
  f=$1
  git add $f
  git commit -v -m "add ${f}"
}

function lc() {
  if [[ $(basename "$PWD") == "leetcode" ]]; then
    f=$(ls -t | head -n 1)
    commit_file $f
  fi
}

function take() {
  mkdir -p $1
  pushd $1 >/dev/null
}

function timezsh() {
  for i in $(seq 1 10);
    do
      /usr/bin/time /bin/zsh -i -c exit;
    done
}
