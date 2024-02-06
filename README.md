# Andrew's LunarVim configurations

Welcome to clone and apply my LunarVim configurations!  
If you find them helpful, please consider leaving a lovely :star:.

---

## Prerequisites
Before diving in, ensure that you have NeoVim (version >= 0.9) and LunarVim installed.  

### Install NeoVim
If you're using Ubuntu, you can easily manage NeoVim versions with [bob](https://github.com/MordechaiHadad/bob), a NeoVim version manager.  
After installing bob, you can install NeoVim with the following command:  
```sh
$ bob install v0.9.5 # or any version above 0.9.0
```

Next, switch to the desired version:
```sh
$ bob use v0.9.5
```

After that, You can verify the installation by running `nvim --version` to ensure that NeoVim is successfully installed.

### Install LunarVim
LunarVim is an open-source Neovim configuration framework designed to provide a modern and efficient Vim experience out of the box.  

For installing LunarVim, you can check out their [website](https://www.lunarvim.org/) or execute the following commands:  
```sh
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
```

Then, run `lvim --version` to make sure that LunarVim is correctly installed.

---

## Apply the configurations

Navigate to ~/.config and download this repository there.
```sh
$ cd ~/.config
$ git clone git@github.com/shiangogo/my_lvim_config.git
$ mv my_lvim_config lvim
```

With these steps completed, you'll be all set to enjoy the power and flexibility of LunarVim in your workflow.
