# This version of init script
# - Does not initialize conda in root
#   Most of time root does not need conda, if required to update conda, run the code block below manually
# - Does not re-initialize conda if it is already performed
#   If user deactivate conda and submit a job with qsub -V, conda will not be re-initialized

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
CONDA_PATH=/opt/anaconda3

if [[ $USER != 'root' && -z "$CONDA_INITIALIZED" ]]; then
    __conda_setup="$($CONDA_PATH'/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
            . "$CONDA_PATH/etc/profile.d/conda.sh"
        else
            export PATH="$CONDA_PATH/bin:$PATH"
        fi
    fi
    unset __conda_setup
	export CONDA_INITIALIZED=1
fi
# <<< conda initialize <<<
