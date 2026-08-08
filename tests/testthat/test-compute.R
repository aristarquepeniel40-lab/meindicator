helper_project <- function() {
  meta <- mecore::me_metadata(
    project_name = "p", organization = "o", country = "c", donor = "d", manager = "m",
    start_date = Sys.Date(), end_date = Sys.Date() + 1,
    version = "0.1", description = "d", objectives = "o", sdgs = character(0)
  )
  d <- mecore::me_dataset(name = "d1", data = data.frame(age = c(20, 22, 25, 31)), metadata = meta)
  mecore::me_project(name = "p", metadata = meta, datasets = list(d), indicators = list(), logframe = NULL)
}

test_that("compute_indicator calcule correctement la valeur", {
  meta <- mecore::me_metadata(
    project_name = "p", organization = "o", country = "c", donor = "d", manager = "m",
    start_date = Sys.Date(), end_date = Sys.Date() + 1,
    version = "0.1", description = "d", objectives = "o", sdgs = character(0)
  )
  d <- mecore::me_dataset(name = "d1", data = data.frame(age = c(20, 22, 25, 31)), metadata = meta)
  i <- compute_indicator(d, ~ mean(age), "Age moyen", "annees")
  expect_equal(i@value, 24.5)
})

test_that("compute_project_indicators retrouve le bon dataset par nom", {
  p <- helper_project()
  rec <- list(me_indicator_recipe(dataset_name = "d1", label = "Age moyen",
                                    formula = ~ mean(age), unit = "annees"))
  p2 <- compute_project_indicators(p, rec)
  expect_equal(length(p2@indicators), 1)
  expect_equal(p2@indicators[[1]]@value, 24.5)
})

test_that("compute_project_indicators signale un dataset introuvable", {
  p <- helper_project()
  rec <- list(me_indicator_recipe(dataset_name = "inexistant", label = "x",
                                    formula = ~ mean(x), unit = "u"))
  expect_error(compute_project_indicators(p, rec), regexp = "introuvable")
})

test_that("le generique mecore::compute_indicators() dispatche vers me_project", {
  p <- helper_project()
  rec <- list(me_indicator_recipe(dataset_name = "d1", label = "Age moyen",
                                    formula = ~ mean(age), unit = "annees"))
  p2 <- p |> mecore::compute_indicators(recipes = rec)
  expect_equal(length(p2@indicators), 1)
})
