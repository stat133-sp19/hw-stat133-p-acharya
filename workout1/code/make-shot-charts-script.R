# title: "make-shot-charts-script"
# author: "Poorvi Acharya"
# date: "March 13, 2019"
# output: github_document

library(jpeg)
library(grid)

court_file <- "../images/nba-court.jpg"
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin DUrant (2016 season)') +
  theme_minimal()
curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()

ggsave("../images/andre-iguodala-shot-chart.pdf", thompson_shot_chart, width = 6.5, height = 5)
ggsave("../images/klay-thompson-shot-chart.pdf", thompson_shot_chart, width = 6.5, height = 5)
ggsave("../images/kevin-durant-shot-chart.pdf", thompson_shot_chart, width = 6.5, height = 5)
ggsave("../images/klay-thompson-shot-chart.pdf", thompson_shot_chart, width = 6.5, height = 5)
ggsave("../images/stephen-curry-shot-chart.pdf", thompson_shot_chart, width = 6.5, height = 5)

facetted <- ggplot(data = combined) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Charts (2016 season)') +
  theme_minimal() + facet_wrap(name ~.)

ggsave("../images/gsw-shot-charts.pdf", facetted, width = 8, height = 7)
ggsave("../images/gsw-shot-charts.png", facetted, width = 8, height = 7)
