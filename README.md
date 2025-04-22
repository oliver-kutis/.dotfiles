# Introduction

Creation of this repository is motivated the fact that I've started to use
Alacritty terminal and Neovim.

One resource that really helped me with this is the video from Fireship:

- https://www.youtube.com/watch?v=r_MpUP6aKiQ
  And accompanying repository:
- https://github.com/eieioxyz/Beyond-Dotfiles-in-100-Seconds

> Note: Most of the files are linked using a symlink either to ~ or to ~/.config

## Global gitignore guide for MacOS

Taken from: https://gist.github.com/lohenyumnam/2b127b9c3d1435dc12a33613c44e6308

Find all the files

```
find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch
```

If already commited

```
find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch
```

Add the .DS_Store to global `.gitignore`

```
echo ".DS_Store" >> ~/.gitignore_global
echo "._.DS_Store" >> ~/.gitignore_global
echo "**/.DS_Store" >> ~/.gitignore_global
echo "**/._.DS_Store" >> ~/.gitignore_global
```

Configure git to use this global file
git config --global core.excludesfile ~/.gitignore_global

## alacritty (terminal)

The entire alacritty config is mostly based on this [article](https://www.josean.com/posts/how-to-setup-alacritty-terminal)

To configure ability to have itallic fonts, I used this [guide](https://michenriksen.com/posts/italic-text-in-alacritty-tmux-neovim/)

## .p10k.zsh (custom zsh terminal)

Making the terminal less boring :D

## nvim

Lots of config, plugins, ...
This again was configured with help of this [vid](https://www.youtube.com/watch?v=6pAG3BHurdM)
and this [article](https://www.josean.com/posts/how-to-setup-neovim-2024)

At the time of creation of this repo, I'm completely new to Neovim.

## Tmux

I was following this guide to set it up: https://www.josean.com/posts/tmux-setup
