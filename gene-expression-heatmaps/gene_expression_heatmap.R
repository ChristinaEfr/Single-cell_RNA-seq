# Load required libraries
library(dplyr)
library(tidyverse)
library(pheatmap)
library(tibble)

# ----------------------------- #
#        Helper Function        #
# ----------------------------- #

process_dataset <- function(data, genes_of_interest, pval_cutoff = NULL) {
  data$Symbol <- toupper(data$Symbol)
  genes_of_interest$Symbol <- toupper(genes_of_interest$Gene)

  filtered <- data %>%
    filter(Symbol %in% genes_of_interest$Symbol)

  if (!is.null(pval_cutoff)) {
    filtered <- filtered %>% filter(p_adjusted_value < pval_cutoff)
  }

  filtered %>%
    group_by(Symbol) %>%
    summarise(log2_Fold_Change = mean(log2_Fold_Change, na.rm = TRUE))
}

create_combined_matrix <- function(list_of_data, labels) {
  combined <- list_of_data[[1]] %>%
    select(Symbol, log2_Fold_Change) %>%
    rename(!!labels[1] := log2_Fold_Change)

  for (i in 2:length(list_of_data)) {
    temp <- list_of_data[[i]] %>%
      select(Symbol, log2_Fold_Change) %>%
      rename(!!labels[i] := log2_Fold_Change)
    combined <- left_join(combined, temp, by = "Symbol")
  }

  combined_matrix <- combined %>%
    column_to_rownames(var = "Symbol") %>%
    as.matrix()

  combined_matrix[is.na(combined_matrix)] <- 0
  combined_matrix[is.nan(combined_matrix)] <- 0

  return(combined_matrix)
}

plot_heatmap <- function(matrix_data, title) {
  pheatmap(matrix_data,
           cluster_rows = TRUE,
           cluster_cols = TRUE,
           scale = "row",
           color = colorRampPalette(c("blue", "white", "red"))(50),
           main = title)
}

# ----------------------------- #
#         Main Script           #
# ----------------------------- #

# Load datasets (rename files as needed)
dataset_files <- list(
  "Cell_Type_I.csv",   
  "Cell_Type_II.csv",  
  "Cell_Type_III.csv", 
  "Cell_Type_IV.csv"   
)

labels <- c("Cell_Type_I", "Cell_Type_II", "Cell_Type_III", "Cell_Type_IV")

datasets <- lapply(dataset_files, read.csv)
genes_of_interest <- read.csv("gene_list.csv") 

# -------- Full Gene Set Heatmap --------
processed_all <- lapply(datasets, process_dataset, genes_of_interest = genes_of_interest)
heatmap_all <- create_combined_matrix(processed_all, labels)
plot_heatmap(heatmap_all, "Log2 Fold Change Heatmap")

# -------- Significant Genes Only --------
processed_sig <- lapply(datasets, process_dataset, genes_of_interest = genes_of_interest, pval_cutoff = 0.05)
heatmap_sig <- create_combined_matrix(processed_sig, labels)
plot_heatmap(heatmap_sig, "Significant Genes Log2 Fold Change Heatmap")
