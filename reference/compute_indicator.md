# Calculer un indicateur a partir d'une formule et d'un dataset

Evalue `formula` (cote droit, ex. `~ mean(age)`) dans l'environnement
des colonnes de `dataset@data`, et retourne un
[`mecore::me_indicator`](https://rdrr.io/pkg/mecore/man/me_indicator.html)
complet (valeur calculee incluse).

## Usage

``` r
compute_indicator(dataset, formula, label, unit)
```

## Arguments

- dataset:

  Un
  [`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html)
  source.

- formula:

  Formule R a evaluer (ex. `~ mean(age)`). Seul le cote droit est
  evalue.

- label:

  Libelle lisible de l'indicateur.

- unit:

  Unite de mesure (ex. "annees", "%").

## Value

Un
[`mecore::me_indicator`](https://rdrr.io/pkg/mecore/man/me_indicator.html).
