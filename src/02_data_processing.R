set.seed(123)

#We don't want the date columns: our explanation will be given later!
forest_fires <- forest_fires %>%
    select(Temperature:Classes)

# we'll take 75% of the observations and place it on the training set,
#    we use the prop = 0.75 argument to do this
# we also use the strata argument to set
# which column will be the prediction variable.

fire_split <- initial_split(forest_fires, prop = 0.75, strata = Classes)
fire_train <- training(fire_split)
fire_test <- testing(fire_split)

# as you can see, the number of observations/rows in the training is
#    0.754 of the forest_fires set
nrow(fire_train) / nrow(forest_fires)

#this tells us how many entries are on each factor in Classes

fire_training_count <- fire_train %>%
    group_by(Classes) %>%
    summarise(n = n())

fire_training_count

# we calculate some important values:
fire_training_range_fire <- fire_training_fn("fire", range)
fire_training_range_not_fire <- fire_training_fn("not fire", range)

#this shows the average values of the numerical columns when there is fire
fire_training_mean_fire <- fire_training_fn("fire", mean)
fire_training_mean_not_fire <- fire_training_fn("not fire", mean)

#now, we look at the range of values:
fire_training_range_fire
fire_training_range_not_fire

# we also want to look at the average values:
fire_training_mean_fire
fire_training_mean_not_fire