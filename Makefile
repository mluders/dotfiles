all:
	stow --verbose --restow stow
	ls -d */ | grep -v -e stow -e appfolio | xargs stow --restow

work:
	stow --verbose  appfolio
