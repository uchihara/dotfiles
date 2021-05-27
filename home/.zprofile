#/bin/zsh

if which keychain >/dev/null 2>&1; then
  eval "$(keychain -q --eval)"
fi

if find ~/.ssh -name 'delish-*.pem' >/dev/null 2>&1; then
  ssh-add ~/.ssh/delish-*.pem
fi
