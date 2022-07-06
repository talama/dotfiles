all:
	stow --verbose --target=$$HOME --restow */
fish:
	stow --verbose --target=$$HOME --restow fish
git:
	stow --verbose --target=$$HOME --restow git
kitty:
		stow --verbose --target=$$HOME --restow kitty
nvim:
		stow --verbose --target=$$HOME --restow nvim
picom:
		stow --verbose --target=$$HOME --restow picom
delete:
	stow --verbose --target=$$HOME --delete */
