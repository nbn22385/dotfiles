# My macOS dotfiles

## Dependencies

* base16-shell
* bat
* fd
* fzf
* ripgrep
* tmux
* vim
* zsh/omz/p10k

## Firefox theme

- Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true` in the Firefox `about:config` window
- Open your Firefox user profile folder using the `about:support` window in Firefox 
- Place `userChrome.css` and `userContent.css` in `~/Library/Application Support/Firefox/Profiles/<DEFAULT_PROFILE>/chrome/`
  - Create the `chrome` directory if it does not yet exist 
