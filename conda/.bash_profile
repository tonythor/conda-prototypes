
# <! -------------------------------------------------------------------
# You should have a .bash_profile, it should look about like this.
# If you use .zshrc, change directory first before you source.
# Mabye try something like ln -s {path of this file} ~/.bash_profile
# <! -------------------------------------------------------------------

export C_PROTO="/Users/afraser/IdeaProjects/conda-prototypes"
source $C_PROTO/conda/profile_rc.sh
export JAVA_HOME=$(/usr/libexec/java_home -v1.8)
alias proto="cd $C_PROTO"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
