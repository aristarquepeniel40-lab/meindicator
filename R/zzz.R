# Necessaire car meindicator enregistre des methodes sur des generiques
# DEFINIS DANS mecore (compute_indicators). S7 exige un enregistrement
# explicite au chargement du package pour les methodes cross-package -
# sans ce hook, la methode existe en memoire mais le generique ne la
# "voit" pas lors du dispatch (erreur "Can't find method for...").
# Voir : https://rconsortium.github.io/S7/articles/packages.html
.onLoad <- function(libname, pkgname) {
  S7::methods_register()
}
