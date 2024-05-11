
# Integrate with exist dotfiles collection

```bash
cd ~/.dotfiles
git init
git submodule add https://github.com/anishathalye/dotbot
# ignore dirty commits in the submodule
git config -f .gitmodules submodule.dotbot.ignore dirty

cp dotbot/tools/git-submodule/install .
./install
```

# docs
https://github.com/anishathalye/dotbot?tab=readme-ov-file#full-example
