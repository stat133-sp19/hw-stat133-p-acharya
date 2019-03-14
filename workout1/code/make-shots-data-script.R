curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)

curry <- mutate(curry, name = 'Stephen Curry')
durant <- mutate(durant, name = 'Kevin Durant')
thompson <- mutate(thompson, name = 'Klay Thompson')
green <- mutate(green, name = 'Graymond Green')
iguodala <- mutate(iguodala, name = 'Andre Iguodala')

curry[curry$shot_made_flag == "y", ]$shot_made_flag <- "shot_yes"
curry[curry$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

durant[durant$shot_made_flag == "y", ]$shot_made_flag <- "shot_yes"
durant[durant$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

thompson[thompson$shot_made_flag == "y", ]$shot_made_flag <- "shot_yes"
thompson[thompson$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

green[green$shot_made_flag == "y", ]$shot_made_flag <- "shot_yes"
green[green$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

iguodala[iguodala$shot_made_flag == "y", ]$shot_made_flag <- "shot_yes"
iguodala[iguodala$shot_made_flag == "n", ]$shot_made_flag <- "shot_no"

curry <- mutate(curry, minute = period*12 - minutes_remaining)
durant <- mutate(durant, minute = period*12 - minutes_remaining)
thompson <- mutate(thompson, minute = period*12 - minutes_remaining)
green <- mutate(green, minute = period*12 - minutes_remaining)
iguodala <- mutate(iguodala, minute = period*12 - minutes_remaining)

sink("../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink("../output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink("../output/stephen-curry-summary.txt")
summary(curry)
sink()

sink("../output/kevin-durant-summary.txt")
summary(durant)
sink()

sink("../output/draymond-green-summary.txt")
summary(green)
sink()

combined <- rbind(curry, durant, thompson, green, iguodala)
write.csv(combined, "../data/shots-data.csv")

sink("../output/shots-data-summary.txt")
summary(combined)
sink()