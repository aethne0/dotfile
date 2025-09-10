if status is-interactive
    set fish_greeting

    set -l os_name (cat /etc/*-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/"//g')
    set -l kernel_ver (uname -r)
    set -l shell_ver $version

    string join '' -- (set_color -b blue black) " fish " $shell_ver ' ' (set_color normal) \
        " (" (set_color yellow) $os_name ' ' (set_color cyan) $kernel_ver (set_color normal) ")"

    #    neofetch
end

alias e 'eza -la'
alias ls 'eza -i'
alias c clear
alias vim nvim
alias vi nvim
alias v nvim
alias ip 'ip -c'
alias ff 'fastfetch'

alias fff "source ~/.config/fish/config.fish"
alias fft "tmux source-file ~/.config/tmux/tmux.conf"

alias sun "https https://aa.usno.navy.mil/api/rstt/oneday?date=(date +%F)&coords=43.6,79.4&tz=-4"
alias moon "https https://aa.usno.navy.mil/api/moon/phases/date?date=(date +%F)&tz=-4&nump=4"
alias weather 'curl https://www.wttr.in/43.655,-79.354'

fish_vi_key_bindings


