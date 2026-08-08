#' Recette de calcul d'indicateur
#'
#' Decrit COMMENT calculer un indicateur (quel dataset, quelle formule,
#' quel libelle/unite) sans encore le calculer. Permet de definir a
#' l'avance tous les indicateurs d'un projet, puis de les calculer en
#' une seule passe avec `compute_project_indicators()`.
#'
#' @param dataset_name Nom du `mecore::me_dataset` cible (doit exister
#'   dans `project@datasets`).
#' @param label Libelle lisible de l'indicateur.
#' @param formula Formule R a evaluer (ex. `~ mean(age)`).
#' @param unit Unite de mesure.
#' @export
me_indicator_recipe <- S7::new_class(
  "me_indicator_recipe",
  package = "meindicator",
  properties = list(
    dataset_name = S7::class_character,
    label        = S7::class_character,
    formula      = S7::new_S3_class("formula"),
    unit         = S7::class_character
  )
)

#' Calculer tous les indicateurs d'un projet a partir de recettes
#'
#' Pour chaque recette, retrouve le `me_dataset` correspondant dans
#' `project@datasets` (par nom), calcule l'indicateur, et l'ajoute a
#' `project@indicators`.
#'
#' @param project Un `mecore::me_project`.
#' @param recipes Liste de `me_indicator_recipe`.
#' @return Le `mecore::me_project` mis a jour (nouveaux indicateurs ajoutes).
#' @export
compute_project_indicators <- function(project, recipes) {
  if (!S7::S7_inherits(project, mecore::me_project)) {
    mecore::me_validation_error("`project` doit etre un mecore::me_project")
  }

  noms_datasets <- vapply(project@datasets, function(d) d@name, character(1))

  nouveaux <- lapply(recipes, function(r) {
    idx <- which(noms_datasets == r@dataset_name)
    if (length(idx) == 0) {
      mecore::me_validation_error(sprintf(
        "dataset '%s' introuvable dans le projet '%s'",
        r@dataset_name, project@name
      ))
    }
    compute_indicator(
      dataset = project@datasets[[idx[1]]],
      formula = r@formula,
      label   = r@label,
      unit    = r@unit
    )
  })

  project@indicators <- c(project@indicators, nouveaux)
  project
}
