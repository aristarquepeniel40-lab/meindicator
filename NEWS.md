# meindicator 1.0.0

Première version stable.

## Fonctionnalités

* `compute_indicator()` — calcule un indicateur à partir d'un
  `mecore::me_dataset` et d'une formule R.
* `me_indicator_recipe`/`compute_project_indicators()` — calcule
  plusieurs indicateurs d'un coup à partir d'un projet.
* Méthode enregistrée sur `mecore::compute_indicators()`, pour
  `project |> compute_indicators(recipes = ...)`.
* `compute_indicator_by_group()` — désagrégation par groupe (région,
  sexe, etc.), avec champ optionnel `group_by` sur `me_indicator_recipe`.
  Rétrocompatible avec les recettes sans `group_by`.

## Corrections notables

* La désagrégation créait initialement des sous-datasets dérivés
  jamais enregistrés dans `project@datasets`, ce que la règle
  `indicateurs_datasets_presents` de `mecheck` détectait à raison.
  Corrigé : chaque indicateur désagrégé référence désormais le dataset
  original.
