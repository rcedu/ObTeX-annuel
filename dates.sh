#!/bin/bash - 
#<1 === Description ================================================
#          FILE: date.sh
#   DESCRIPTION: construit une commande LaTeX avec dates de la
#                semaine de cours
#         NOTES: 
#        AUTHOR: Cyril Rouiller
#       CREATED: 2023-06-27
#      REVISION: 


#<1 === Gestion des erreurs ========================================
set -Eeuo pipefail

ER(){
	gprintf "##ERR %3s: %s.\n" $1 "$2";
	exit $1;
}


#<1 === Constantes =================================================

# premier lundi de cours de l'année
premlu=2022-08-29

# nombre de semaines, vacances comprises
nbsem=45

# jour de la semaine (1=mardi)
nbj=0

# format de sortie
fmtd=+"%a %d %b %y"

# vérification que la date donnée soit un lundi
premlutest=$(gdate -d "$premlu" +"%a")
[[ "$premlutest" != "Lun" ]] && ER 1 "Le $premlu n'est pas un lundi mais un $premlutest"
unset premlutest


#<1 === main =======================================================
# initialisation de la boucle une semaine à l'avance
mylubas=$(gdate -d "$premlu-7 days" +"%D")

for i in $(seq $nbsem) ; do

	# variables intermédiare, sinon bogue à cause du jour de la semaine
	mylubas=$(gdate -d "$mylubas+7 days" +"%D")

	# var pour le lundi, le vendredi et le jour de cours
	mylu=$(gdate -d "$mylubas" "$fmtd")
	myve=$(gdate -d "$mylubas+4 days" "$fmtd")
	myjo=$(gdate -d "$mylubas+$nbj days" "$fmtd")

	gprintf "\semai{%2s}{%s}{%s}{%s}{}\n" "$i" "$mylu" "$myve" "$myjo"

done



#<1 === Fin de script ==============================================
exit 0
# vim: set ts=3 sts=3 sw=3 tw=80 fdm=marker fmr=#<,#> filetype=bash:
