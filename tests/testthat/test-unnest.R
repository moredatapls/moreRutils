context("unnest-variable-length")

test_that("unnesting with variable length list column works", {

  # define input and output
  data <- dplyr::mutate(data.frame(id = c(1, 2, 3)),
                        list = strsplit(c("a", "b,c", "d,e,f"), ","))
  dataNamed <- dplyr::mutate(data.frame(id = c(1, 2, 3, 4)),
                             list = list(c(one = "a"), c(one = "b", two = "c"), c(one = "d", two = "e", three = "f"), c()))

  expected <- data.frame(
    id = c(1, 2, 2, 3, 3, 3),
    list = c("a", "b", "c", "d", "e", "f"),
    stringsAsFactors = F
  )

  expectedNamed <- data.frame(
    id = c(1, 2, 2, 3, 3, 3, 4),
    list = c("a", "b", "c", "d", "e", "f", NA_character_),
    names = c("one", "one", "two", "one", "two", "three", NA_character_),
    stringsAsFactors = F
  )

  # run it
  actual <- unnest_names(data, list)
  actualNamed <- unnest_names(dataNamed, list, keep_names = "names")

  # check it
  expect(isTRUE(dplyr::all_equal(expected, actual)), "result not equal")
  expect(isTRUE(dplyr::all_equal(expectedNamed, actualNamed)), "named result not equal")

})
