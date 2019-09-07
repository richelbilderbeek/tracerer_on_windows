# R script to self-test tracerer

print("=====================")
print("Self-testing tracerer")
print("=====================")

library(tracerer)

print("------------")
print("Session info")
print("------------")

print(sessionInfo())

print("--------------------------")
print("tracerer's package version")
print("--------------------------")

print(packageVersion("tracerer"))

print("---------------")
print("Start self-test")
print("---------------")

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

print("============================")
print("Self-testing tracerer passed")
print("============================")
