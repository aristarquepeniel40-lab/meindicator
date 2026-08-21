# Recette de calcul d'indicateur

Decrit COMMENT calculer un indicateur (quel dataset, quelle formule,
quel libelle/unite) sans encore le calculer. Permet de definir a
l'avance tous les indicateurs d'un projet, puis de les calculer en une
seule passe avec
[`compute_project_indicators()`](https://aristarquepeniel40-lab.github.io/meindicator/reference/compute_project_indicators.md).

## Usage

``` r
me_indicator_recipe(
  dataset_name = character(0),
  label = character(0),
  formula = (function (.data) 
 {
    
    stop(sprintf("S3 class <%s> doesn't have a constructor", class[[1]]), call. =
    FALSE)
 })(),
  unit = character(0),
  group_by = character(0)
)
```

## Arguments

- dataset_name:

  Nom du
  [`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html)
  cible (doit exister dans `project@datasets`).

- label:

  Libelle lisible de l'indicateur.

- formula:

  Formule R a evaluer (ex. `~ mean(age)`).

- unit:

  Unite de mesure.

- group_by:

  Colonne de regroupement optionnelle (ex. "region"). Si fournie,
  produit UN indicateur par modalite plutot qu'une seule valeur globale
  (voir
  [`compute_indicator_by_group()`](https://aristarquepeniel40-lab.github.io/meindicator/reference/compute_indicator_by_group.md)).
