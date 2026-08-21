# Calculer un indicateur desagrege par groupe

Calcule un indicateur separement pour chaque modalite d'une colonne de
regroupement (ex. par region, par sexe), plutot qu'une seule valeur
globale. Retourne UN indicateur par modalite.

## Usage

``` r
compute_indicator_by_group(
  dataset,
  group_by,
  formula,
  label,
  unit,
  na_rm_groupes = TRUE
)
```

## Arguments

- dataset:

  Un
  [`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html)
  source.

- group_by:

  Nom de la colonne de regroupement (ex. "region").

- formula:

  Formule R a evaluer au sein de chaque groupe.

- label:

  Libelle de base ; chaque indicateur genere aura pour libelle
  `"<label> (<group_by> = <modalite>)"`.

- unit:

  Unite de mesure.

- na_rm_groupes:

  Si `TRUE` (par defaut), ignore les lignes ou `group_by` est manquant
  plutot que de creer un groupe "NA".

## Value

Liste de
[`mecore::me_indicator`](https://rdrr.io/pkg/mecore/man/me_indicator.html),
un par modalite du groupe.

## Details

Important : chaque indicateur genere reference le dataset ORIGINAL (pas
un sous-dataset derive) — sinon `mecheck::run_checks()` signale a juste
titre une reference vers un dataset absent de `project@datasets` (bug
trouve en testant sur donnees reelles). Le filtrage par modalite reste
un detail de calcul interne.
