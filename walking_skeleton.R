library(mecore)
library(meindicator)
library(S7)

meta <- me_metadata(
  project_name = "Pilote meindicator", organization = "Universite de Parakou",
  country = "Benin", donor = "N/A", manager = "Peniel",
  start_date = Sys.Date(), end_date = Sys.Date() + 365,
  version = "0.1", description = "test", objectives = "test", sdgs = character(0)
)

d_age <- me_dataset(name = "enquete_age", data = data.frame(age = c(20, 22, 25, 31)), metadata = meta)
d_rev <- me_dataset(name = "enquete_revenu", data = data.frame(revenu = c(50000, 75000, 60000)), metadata = meta)

p <- me_project(name = "Pilote", metadata = meta, datasets = list(d_age, d_rev),
                 indicators = list(), logframe = NULL)

recettes <- list(
  me_indicator_recipe(dataset_name = "enquete_age", label = "Age moyen",
                       formula = ~ mean(age), unit = "annees"),
  me_indicator_recipe(dataset_name = "enquete_revenu", label = "Revenu median",
                       formula = ~ median(revenu), unit = "FCFA")
)

# Voie 1 : appel direct
p2 <- compute_project_indicators(p, recettes)
stopifnot(length(p2@indicators) == 2)
cat("Voie directe : OK -", p2@indicators[[1]]@value, "/", p2@indicators[[2]]@value, "\n")

# Voie 2 : via le generique mecore::compute_indicators() (convention pipe du §5)
p3 <- p |> compute_indicators(recipes = recettes)
stopifnot(length(p3@indicators) == 2)
cat("Voie generique (pipe) : OK -", p3@indicators[[1]]@value, "/", p3@indicators[[2]]@value, "\n")

# Cas d'erreur : dataset introuvable
mauvaise_recette <- list(me_indicator_recipe(dataset_name = "inexistant", label = "x",
                                              formula = ~ mean(x), unit = "u"))
res <- tryCatch(compute_project_indicators(p, mauvaise_recette), error = function(e) conditionMessage(e))
cat("Erreur attendue :", res, "\n")

cat("\nTOUS LES TESTS MEINDICATOR PASSENT.\n")
