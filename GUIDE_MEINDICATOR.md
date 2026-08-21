# Guide d’intégration — meindicator

Comme pour `mecore`, tout ce code a été **réellement testé** dans mon
environnement : `mecore` installé comme vrai package, `meindicator`
installé par-dessus, walking skeleton exécuté avec succès (voir la
sortie en fin de guide). Un bug reel a été trouvé et corrige en route
(voir §3).

## 1. Pré-requis

`meindicator` dépend de `mecore` — installe d’abord `mecore` chez toi
(déjà fait normalement), puis place ce dossier `meindicator/` à côté de
ton dossier `mecore/` (pas dedans).

## 2. Première installation

Comme pour `mecore`, il n’y a **volontairement pas de `NAMESPACE`** dans
cette archive — on a appris avec `mecore` qu’un `NAMESPACE` manuel ou
obsolète cause des problèmes silencieux. Laisse `roxygen2` le générer :

``` r

setwd("chemin/vers/meindicator")
devtools::document()   # genere NAMESPACE + .Rd depuis les tags roxygen2
devtools::load_all(".")
source("walking_skeleton.R")   # doit afficher "TOUS LES TESTS MEINDICATOR PASSENT."
devtools::test()
devtools::check()
```

## 3. Un point technique important (trouvé en testant)

`meindicator` enregistre une méthode sur `compute_indicators()`, un
générique **défini dans `mecore`**, pas dans `meindicator`. S7 exige un
enregistrement explicite pour ce cas précis (“cross-package methods”),
sans quoi le générique ne “voit” pas la méthode même si elle est bien
enregistrée en mémoire (erreur `Can't find method for...`). C’est fait
dans `R/zzz.R` :

``` r

.onLoad <- function(libname, pkgname) {
  S7::methods_register()
}
```

Retiens cette règle pour tous les futurs packages `me*` : **dès qu’un
package enregistre une méthode sur un générique d’un autre package
MEverse, il lui faut un `zzz.R` avec ce hook.** À ajouter à
`ARCHITECTURE.md` §5 (convention d’API) pour que ce ne soit pas oublié
sur `medata`, `mereport`, etc.

## 4. Ce que fait ce package (V1 minimale)

- `compute_indicator(dataset, formula, label, unit)` — calcule un seul
  indicateur à partir d’un `me_dataset` et d’une formule.
- `me_indicator_recipe` — décrit un indicateur à calculer sans encore le
  calculer (dataset cible par nom, formule, libellé, unité).
- `compute_project_indicators(project, recipes)` — calcule plusieurs
  indicateurs d’un coup et les ajoute au projet.
- Méthode enregistrée sur
  [`mecore::compute_indicators()`](https://rdrr.io/pkg/mecore/man/compute_indicators.html)
  pour respecter la convention pipe du §5 :
  `project |> compute_indicators(recipes = ...)`.

## 5. Sortie réelle du walking skeleton (testée ici)

    Voie directe : OK - 24.5 / 60000
    Voie generique (pipe) : OK - 24.5 / 60000
    Erreur attendue : dataset 'inexistant' introuvable dans le projet 'Pilote'

    TOUS LES TESTS MEINDICATOR PASSENT.

## 6. Prochaine étape suggérée après validation

Une fois `devtools::check()` propre (même critère que `mecore` : erreurs
à 0, warnings/notes documentés si non bloquants), commit, puis mise à
jour d’`ARCHITECTURE.md` avec la règle du `zzz.R` (§3 ci-dessus) avant
de démarrer le package suivant.
