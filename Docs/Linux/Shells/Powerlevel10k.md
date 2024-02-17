# **INSTALL ZSH SHELL IN WSL / WSL2**

Now we need to install the “zsh” shell in our wsl or wsl2. You can easily install it in the Ubuntu wsl by using the commands below. If you’re using a different Linux distribution, you may check out the zsh documentation or your package manager documentation.

We will also install oh-my-zsh which is a nice configuration extension to the “zsh” shell. That will allow us to easily customize anything, install a theme, and add plugins later.

```
sudo apt update

sudo apt install zsh -y

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

# **INSTALL POWERLEVEL10K ZSH THEME**

Next, we will install the powerlevel10k theme, which really looks nice and offers great customization features. It also has a good configuration wizard that makes it extremely easy to set up the theme for your favorite design.

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

To activate the theme you need to edit your “~/.zshrc” file in your personal folder and replace ZSH_THEME=”robbyrussel” with ZSH_THEME=”powerlevel10k/powerlevel10k”. After the change, you need to close and restart your terminal.

GitHub: https://github.com/romkatv/powerlevel10k

# **CHANGE WINDOWS TERMINAL SETTINGS TO USE NERD-FONTS**

We must modify the Windows Terminal setup to utilize the Nerd-Font we previously obtained if we want Windows Terminal to appropriately portray the icons in the powerlevel10k theme. Edit the settings by selecting "Settings" from the Windows Terminal menu. Using your preferred text editor, and edit the settings.json file.

Find your wsl, wsl2, or Command Prompt profile and add the line “face”: “<name-of-your-font>” according to this example:

```
"list":
    [
        {
            "guid": "{<your-profile-id>}",
            "font":
            {
                "face": "<name-of-your-font>"
            },
            "hidden": false,
            "name": "Ubuntu-20.04",
            "source": "Windows.Terminal.Wsl"
        }
    ]
```

```
Make sure, you’re using the exact name of the font like it’s displayed in the “Font name” section when you open the .otf font file!
```

# **SOME ADDITIONAL SETTINGS IN WINDOWS TERMINAL**

The settings.json file of Windows Terminal can be configured with different options. You can change the name, the icon, the default folder, font-size and many other things.

If you want to have a look at the configuration I’m using in my Windows Terminal, you can check out my dotfiles.

My dotfiles: https://github.com/xcad2k/dotfiles

# **HOW TO INSTALL OR ENABLE PLUGINS IN ZSH**

EXAMPLE: AUTO-SUGGESTION PLUGIN
I found this nice auto-suggestion plugin for the “zsh” shell. Above all, it’s really nice and helps me a lot when working with the Linux terminal. It will suggest you auto-completes based on your command history.

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

GitHub: https://github.com/zsh-users/zsh-autosuggestions

ENABLE THE PLUGINS IN ZSH

To enable the auto-suggestion plugin or any other plugins in “zsh”, edit your “~/.zshrc” file in your personal folder. Simply change the default line plugins=(git) to plugins=(git zsh-autosuggestions <optional-other-plugins>). Of course, replace the <optional-other-plugins> with any other plugins you want to enable.

```
nano ~/.zshrc
```

Now open a new terminal and log into your machine again.

# **Edit Powerlevel10k configuration file**

```
nano ~/.p10k.zsh
```

Add/uncomment the segments you want to see/use.

# **Fix Oh My Zsh “Insecure completion-dependent directories detected”**

```
chmod -R 755 <locations_that_appear>
```

##### Guides:

https://www.the-digital-life.com/awesome-wsl-wsl2-terminal/

https://github.com/romkatv/powerlevel10k
