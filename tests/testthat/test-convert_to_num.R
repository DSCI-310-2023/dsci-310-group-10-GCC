library(testthat)
library(here)

source(here("R/convert_to_num.R"))

# create a data frame to be tested
df1 <- data.frame(c_to_n = c("1", "2"))

# apply the function to the data frame
df1_test <- convert_to_num(df1, "c_to_n")

# define the expected output
df1_expect <- data.frame(c_to_n = c(1,2))

# create a vector to be tested
df2 <- c(1,2,3)


# check expected 1
test_that("`convert_to_num` should return a data frame", {
  expect_equal(df1_test, df1_expect)
})

# create a vector to be tested
df2 <- c(1,2,3)


test_that("pass a data frame to `convert_to_num`", {
  expect_error(convert_to_num(df2, 2))
    expect_error(convert_to_num(df1, '3'))
})