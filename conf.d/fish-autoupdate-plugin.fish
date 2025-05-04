function _fish_autoupdate_plugin
    # don't run if explicitly disabled
    set -q faup_disabled
    and test $faup_disabled = true
    and return     

    # only run in interactive session to make sure user is aware of update
    if not status is-interactive
        return
    end

    # only run at shell startup
    if test (status current-command | tr -d '\n') != "fish"
        return
    end

    # check if a day has passed since the last autoupdate
    if set -q faup_last_update
        set -q faup_update_delta
        and set -l delta $faup_update_delta
        or set -l delta "24*60*60"
    
        if test $faup_last_update -gt (math (date +%s) - $delta)
            return
        end
    end

    # prepare lock file path
    if set -q XDG_RUNTIME_DIR
        set lockdir $XDG_RUNTIME_DIR
    else if set -q TMPDIR
        set lockdir $TMPDIR
    else
        set lockdir "/tmp"
    end
    set -l lock "$lockdir/fish-autoupdate-plugin.$USER"

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
        echo "[faup]: downloading plugin list from $faup_url, saving to $target"
        
        set -q faup_target
        and set -l target $faup_target
        or set -l target "$HOME/.config/fish/fish_plugins"
        
        curl -L $faup_url -o $target
        if test $status != 0
            echo "[faup]: downloading plugin list failed"
        end
    end

    # trigger update
    switch $faup_plugin_manager
        case omf
            omf update
        case fisher '*'
            fisher update
    end
    if test $status != 0
        echo "[faup]: update failed, consult plugin manager for further detail"
    end

    # cleanup
    set -U faup_last_update (date +%s)
    rm $lock
    echo "[faup]: automatic update complete"
end

_fish_autoupdate_plugin
