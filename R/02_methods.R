# Enregistre la methode du generique mecore::compute_indicators() pour
# me_project, afin de respecter la convention d'API du pipe natif :
#   project |> compute_indicators(recipes = mes_recettes)
#
# Note technique (piege trouve en testant) : on ne peut PAS compter sur
# @importFrom pour rendre `compute_indicators`/`me_project` disponibles
# ici, car devtools::document() doit d'abord CHARGER ce fichier pour en
# extraire les tags roxygen2 - avant meme de regenerer le NAMESPACE qui
# contiendrait cet import. Poule et oeuf. On cree donc des alias locaux
# explicites via `mecore::`, qui fonctionnent quel que soit l'etat du
# NAMESPACE (mecore est deja installe, donc toujours accessible ainsi).
compute_indicators <- mecore::compute_indicators
me_project <- mecore::me_project

# Seul le generique (deja expose par mecore) est exporte ; cette methode
# ne necessite pas sa propre page de documentation (voir ARCHITECTURE.md §5).
#' @noRd
S7::method(compute_indicators, me_project) <- function(x, ..., recipes) {
  compute_project_indicators(x, recipes)
}
