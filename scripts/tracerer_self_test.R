# R script to self-test tracerer

message("=====================")
message("Self-testing tracerer")
message("=====================")

library(tracerer)

message("------------")
message("Session info")
message("------------")

message(paste0(devtools::session_info(), collapse = "\n"))

message("--------------------------")
message("tracerer's package version")
message("--------------------------")

message(packageVersion("tracerer"))

message("---------------")
message("Start self-test")
message("---------------")

estimates <- parse_beast_log(
  get_tracerer_path("beast2_example_output.log")
)
estimates <- remove_burn_ins(estimates, burn_in_fraction = 0.1)
esses <- calc_esses(estimates, sample_interval = 1000)
table <- t(esses)
colnames(table) <- c("ESS")
knitr::kable(table)

sum_stats <- calc_summary_stats(
  estimates$posterior,
  sample_interval = 1000
)
table <- t(sum_stats)
colnames(table) <- c("sum_stat")
knitr::kable(table)


sum_stats <- calc_summary_stats(
  estimates,
  sample_interval = 1000
)
knitr::kable(sum_stats)

ggplot2::ggplot(
  data = remove_burn_ins(estimates, burn_in_fraction = 0.1),
  ggplot2::aes(posterior)
) + ggplot2::geom_histogram(binwidth = 0.21) + ggplot2::scale_x_continuous(breaks = seq(-75,-68))


ggplot2::ggplot(
  data = remove_burn_ins(estimates, burn_in_fraction = 0.1),
  ggplot2::aes(x = Sample)
) + ggplot2::geom_line(ggplot2::aes(y = posterior))


trees <- parse_beast_trees(
  get_tracerer_path("beast2_example_output.trees")
)

message("============================")
message("Self-testing tracerer passed")
message("============================")
