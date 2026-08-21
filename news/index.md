# Changelog

## meindicator 1.0.0

Première version stable.

### Fonctionnalités

- [`compute_indicator()`](https://aristarquepeniel40-lab.github.io/meindicator/reference/compute_indicator.md)
  — calcule un indicateur à partir d’un
  [`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html)
  et d’une formule R.
- `me_indicator_recipe`/[`compute_project_indicators()`](https://aristarquepeniel40-lab.github.io/meindicator/reference/compute_project_indicators.md)
  — calcule plusieurs indicateurs d’un coup à partir d’un projet.
- Méthode enregistrée sur
  [`mecore::compute_indicators()`](https://rdrr.io/pkg/mecore/man/compute_indicators.html),
  pour `project |> compute_indicators(recipes = ...)`.
- [`compute_indicator_by_group()`](https://aristarquepeniel40-lab.github.io/meindicator/reference/compute_indicator_by_group.md)
  — désagrégation par groupe (région, sexe, etc.), avec champ optionnel
  `group_by` sur `me_indicator_recipe`. Rétrocompatible avec les
  recettes sans `group_by`.

### Corrections notables

- La désagrégation créait initialement des sous-datasets dérivés jamais
  enregistrés dans `project@datasets`, ce que la règle
  `indicateurs_datasets_presents` de `mecheck` détectait à raison.
  Corrigé : chaque indicateur désagrégé référence désormais le dataset
  original.
