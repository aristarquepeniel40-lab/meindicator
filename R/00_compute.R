#' Calculer un indicateur a partir d'une formule et d'un dataset
#'
#' Evalue `formula` (cote droit, ex. `~ mean(age)`) dans l'environnement
#' des colonnes de `dataset@data`, et retourne un `mecore::me_indicator`
#' complet (valeur calculee incluse).
#'
#' @param dataset Un `mecore::me_dataset` source.
#' @param formula Formule R a evaluer (ex. `~ mean(age)`). Seul le cote
#'   droit est evalue.
#' @param label Libelle lisible de l'indicateur.
#' @param unit Unite de mesure (ex. "annees", "%").
#' @return Un `mecore::me_indicator`.
#' @export
compute_indicator <- function(dataset, formula, label, unit) {
  if (!S7::S7_inherits(dataset, mecore::me_dataset)) {
    mecore::me_validation_error("`dataset` doit etre un mecore::me_dataset")
  }
  if (!inherits(formula, "formula")) {
    mecore::me_validation_error("`formula` doit etre une formule R (ex. ~ mean(age))")
  }

  valeur <- eval(formula[[length(formula)]], envir = dataset@data)

  mecore::me_indicator(
    label    = label,
    formula  = formula,
    datasets = list(dataset),
    value    = valeur,
    unit     = unit
  )
}

#' Calculer un indicateur desagrege par groupe
#'
#' Calcule un indicateur separement pour chaque modalite d'une colonne
#' de regroupement (ex. par region, par sexe), plutot qu'une seule
#' valeur globale. Retourne UN indicateur par modalite.
#'
#' Important : chaque indicateur genere reference le dataset ORIGINAL
#' (pas un sous-dataset derive) — sinon `mecheck::run_checks()` signale
#' a juste titre une reference vers un dataset absent de
#' `project@datasets` (bug trouve en testant sur donnees reelles). Le
#' filtrage par modalite reste un detail de calcul interne.
#'
#' @param dataset Un `mecore::me_dataset` source.
#' @param group_by Nom de la colonne de regroupement (ex. "region").
#' @param formula Formule R a evaluer au sein de chaque groupe.
#' @param label Libelle de base ; chaque indicateur genere aura pour
#'   libelle `"<label> (<group_by> = <modalite>)"`.
#' @param unit Unite de mesure.
#' @param na_rm_groupes Si `TRUE` (par defaut), ignore les lignes ou
#'   `group_by` est manquant plutot que de creer un groupe "NA".
#' @return Liste de `mecore::me_indicator`, un par modalite du groupe.
#' @export
compute_indicator_by_group <- function(dataset, group_by, formula, label, unit, na_rm_groupes = TRUE) {
  if (!S7::S7_inherits(dataset, mecore::me_dataset)) {
    mecore::me_validation_error("`dataset` doit etre un mecore::me_dataset")
  }
  if (!(group_by %in% names(dataset@data))) {
    mecore::me_validation_error(sprintf("colonne de regroupement '%s' introuvable dans le dataset", group_by))
  }

  col_groupe <- dataset@data[[group_by]]
  modalites <- unique(col_groupe)
  if (na_rm_groupes) modalites <- modalites[!is.na(modalites)]
  modalites <- sort(modalites)

  lapply(modalites, function(g) {
    lignes <- !is.na(col_groupe) & col_groupe == g
    sous_data <- dataset@data[lignes, , drop = FALSE]
    valeur <- eval(formula[[length(formula)]], envir = sous_data)

    mecore::me_indicator(
      label    = sprintf("%s (%s = %s)", label, group_by, g),
      formula  = formula,
      datasets = list(dataset),  # dataset ORIGINAL, pas un sous-dataset derive
      value    = valeur,
      unit     = unit
    )
  })
}
