#!/bin/bash -
#===============================================================================
#
#          FILE: backup.sh
#
#         USAGE: ./backup.sh
#
#   DESCRIPTION: Faz o backup dos principais do sistema
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Raphael P. Ribeiro
#  ORGANIZATION:
#       CREATED: 23-06-2014 20:05:04 BRT
#      REVISION:  ---
#===============================================================================

DIR=raphael@lancassolar:~/backup
LOG=/home/raphael/.backup.log

sudo rsync --delete -avzP -e ssh --log-file=$LOG /etc $DIR
sudo rsync --delete -avzP -e ssh --log-file=$LOG ~/.config $DIR/raphael
sudo rsync --delete -avzP -e ssh --log-file=$LOG /usr/share $DIR/usr/share
sudo rsync --delete -avzP -e ssh --log-file=$LOG /usr/local $DIR/usr/local
pacman -Qqe | grep -v "$(pacman -Qqm)" > pkglist-of && scp pkglist-of $DIR && rm -rf pkglist-of         # Cria uma lista dos pacotes oficiais instalados no sistema
pacman -Qqm > pkglist-loc && scp pkglist-loc $DIR && sudo rm -rf pkglist-loc                            # Cria uma lista dos pacotes locais, inclui os instalados do AUR
scp ~/.backup.log $DIR/backup.log

# rsync options

# --delete
# faz com que arquivos apagados na pasta original sejam apagados também na pasta do backup

# -a
# (archive) faz com que todas as permissões e atributos dos arquivos sejam mantidos

# -v
# (verbose)

# -z
# Comprime os arquivos durante a transferência

# -P
# mostra o progresso durante a transferência
