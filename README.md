# meindicator

**Calcul d'indicateurs pour l'écosystème [MEverse](https://github.com/aristarquepeniel40-lab/mecore).**

Calcule des `mecore::me_indicator` à partir de `mecore::me_dataset` et
de formules R. Supporte le calcul global ou **désagrégé par groupe**
(région, sexe, etc.) — un seul indicateur global peut masquer des
écarts réels que la désagrégation révèle.

## Installation

```r
install.packages("remotes")
remotes::install_github("aristarquepeniel40-lab/mecore")   # dependance
remotes::install_github("aristarquepeniel40-lab/meindicator")
```

## Exemple rapide

```r
library(mecore)
library(meindicator)

meta <- me_metadata(project_name = "p", organization = "o", country = "c", donor = "d",
  manager = "m", start_date = Sys.Date(), end_date = Sys.Date() + 1,
  version = "0.1", description = "d", objectives = "o", sdgs = character(0))

d <- me_dataset(name = "exploitants",
  data = data.frame(rendement = c(1200, 2400, 1800, 900), region = c("Zou", "Zou", "Borgou", "Borgou")),
  metadata = meta)

p <- me_project(name = "p", metadata = meta, datasets = list(d), indicators = list(), logframe = NULL)

# Indicateur global + indicateur desagrege par region, en une seule passe
recettes <- list(
  me_indicator_recipe(dataset_name = "exploitants", label = "Rendement moyen",
                       formula = ~ mean(rendement), unit = "kg/ha"),
  me_indicator_recipe(dataset_name = "exploitants", label = "Rendement moyen",
                       formula = ~ mean(rendement), unit = "kg/ha", group_by = "region")
)
p <- p |> compute_indicators(recipes = recettes)
for (i in p@indicators) cat(i@label, "=", i@value, i@unit, "\n")
```

## Fait partie de l'écosystème MEverse

[mecore](https://github.com/aristarquepeniel40-lab/mecore) (fondations) ·
[medata](https://github.com/aristarquepeniel40-lab/medata) ·
**meindicator** (ce dépôt) ·
[mecheck](https://github.com/aristarquepeniel40-lab/mecheck) ·
[mereport](https://github.com/aristarquepeniel40-lab/mereport)

## Licence

MIT — voir [`LICENSE`](LICENSE).
