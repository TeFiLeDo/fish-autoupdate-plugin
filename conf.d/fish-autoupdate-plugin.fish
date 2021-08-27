function _fish_autoupdate_plugin
    # don't run if explicitly disabled
    set -q faup_disabled
    and test $faup_disabled = true
    and return     

    # only run in interactive session to make sure user is aware of update
    if not status is-interactive
        return
    end

    # check if a day has passed since the last autoupdate
    if set -q faup_last_update
        if test $faup_last_update -gt (math (date +%s) - "24*60*60")
            return
        end
    end

    # prepare lock file path
    set -l lock "/tmp/fish-autoupdate-plugin.$USER"

    # check if lock exists
    if test -L $lock
        set -l lock_pid (readlink $lock)

        # check if locking process is still running
        if test -d "/proc/$lock_pid"
            return
        else
            echo "[faup]: detected lock from inactive process, overriding"
            rm $lock
        end
    end

    # try to obtain lock
    ln -s $fish_pid $lock
    if test $status != 0
        echo "[faup]: tried to initiate automatic update, failed to get lock"
        return
    end
    echo "[faup]: initiating automatic update"

    # download new plugin list
    if set -q faup_url
        set -l target "$HOME/.config/fish/fish_plugins"
        if set -q faup_target
            set target $faup_target
        end
        
        echo "[faup]: downloading plugin list from $faup_url, saving to $target"
        curl -L $faup_url -o $target
        if test $status != 0
            echo "[faup]: downloading plugin list failed"
        end
    end

    # trigger update
    switch $fuap_plugin_manager
        case fisher '*'
            fisher update
    end

    # cleanup
    set -U faup_last_update (date +%s)
    rm $lock
    echo "[faup]: automatic update complete"
end

_fish_autoupdate_plugin
