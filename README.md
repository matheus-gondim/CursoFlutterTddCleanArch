# flutter_clean_architecture

    A new Flutter project.

## Git Config

### COMANDOS

    git config --global --edit => comando para abrir as configs do git
    git tag -a [tag_name] -m [tag_name]

### ALIAS CRIADOS PARA O GIT

    git c => git add --all & git commit -m
    git s => git status -s
    git l => git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'
        %h => mostra o hash reduzido do commit
        %d => mostra qual a branch atual
        %s => mostra o subject do  commit
        %cn => mostra o nome da pessoa que fez o commit
        %cr => mostra a data relativa do commit
        %C() => pinta o proximo campo da cor dentro do parênteses

## Refresh App Launcher Icon

    Instalar primeiramente a dependência flutter_launcher_icons
    flutter pub run flutter_launcher_icons:main
