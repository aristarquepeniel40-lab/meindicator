# Calculer tous les indicateurs d'un projet a partir de recettes

Pour chaque recette, retrouve le `me_dataset` correspondant dans
`project@datasets` (par nom), calcule l'indicateur (ou les indicateurs,
si `group_by` est renseigne), et l'ajoute a `project@indicators`.

## Usage

``` r
compute_project_indicators(project, recipes)
```

## Arguments

- project:

  Un
  [`mecore::me_project`](https://rdrr.io/pkg/mecore/man/me_project.html).

- recipes:

  Liste de `me_indicator_recipe`.

## Value

Le
[`mecore::me_project`](https://rdrr.io/pkg/mecore/man/me_project.html)
mis a jour (nouveaux indicateurs ajoutes).
