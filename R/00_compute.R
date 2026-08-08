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
