# main_template.R

cat("Working directory:", getwd(), "\n")

output_dir <- file.path(getwd(), "outputs/script40")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
cat("Created directory:", output_dir, "\n")

source("DTvsfDT_alg.R")

rho <- 0.5
dt <- 40

keep_trav_cost <-c()
keep_kendall <- c()
keep_agree <- c()
keep_margin <-c()
keep_margin_dt <- c()


for(ii in 1:100){

  obs_gen_para <- read.csv(paste0("pattern/rho_", rho, "_", ii, ".csv"))
  the_result <- DT_vs_fDT_Alg(obs_gen_para, dt)
  
  keep_trav_cost <- c(keep_trav_cost, the_result$trav_cost_dif)
  keep_kendall <- c(keep_kendall, the_result$kendall) 
  keep_agree <- c(keep_agree, the_result$agreement)
  keep_margin <- c(keep_margin, the_result$margin)
  keep_margin_dt <- c(keep_margin_dt, the_result$margin_dt)

}

final_result <- list(trav_cost = mean(keep_trav_cost),
                     kendall = mean(keep_kendall), 
                     agree = mean(keep_agree),
                     margin = mean(keep_margin),
                     margin_dt = mean(keep_margin_dt)
                     )

file_name <- file.path(output_dir, paste0("rho_", dt, "_", rho, ".rds"))
saveRDS(final_result, file = file_name)
