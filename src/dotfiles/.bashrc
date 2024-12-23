#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# grep 
alias grep='grep --color=auto'

# tar
alias untar='tar -xvzf'
alias tarzip='tar -czvf'

# net
alias ports='netstat -tulanp'

# ps
alias pstree='ps axjf'
alias myps='ps -u $USER'

# cd
alias ..='cd ..'
alias ...='cd ../..'

# ls
alias ls='ls --color=auto'
alias ll='ls -alh'
alias l='ls -CF'

# Docker
alias d='docker'
# Docker continers
alias ds='docker ps'
alias dsa='docker ps -a'
alias dr='docker rm'
alias drf='docker rm -f'
alias du='docker start'
alias ds='docker stop'
alias dl='docker logs'
alias de='docker exec -it'
# Docker images
alias di='docker images'
alias dir='docker rmi'
alias drip='docker image prune -af'

# Docker compose
alias dc='docker compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs -f'