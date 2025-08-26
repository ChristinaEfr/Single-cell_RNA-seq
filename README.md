# Single-cell_RNA-seq
Heatmap of gene expression based on single-cell RNA-seq of 4 cell types. The analysis was done in R-studio.
#  Single-Cell RNA-seq Heatmap Generator

This repository contains an R script to visualize **log₂ fold change gene expression** data from single-cell RNA-seq experiments across four different cell types. The goal is to extract expression patterns of selected genes of interest and display them as clustered heatmaps.

---

##  What It Does

- Loads log₂ fold change data (e.g., DESeq2/Seurat output) from `.csv` files
- Filters based on a user-defined gene list
- Optionally filters by significance (FDR < 0.05)
- Averages duplicate gene entries
- Creates heatmaps with `pheatmap`, clustered by rows and columns



---

##  Requirements

Install the following R packages:
```r
install.packages(c("dplyr", "tidyverse", "pheatmap", "tibble"))
```
## How to Run

1. Clone this repo or download the files

2. Place your .csv input files into the data/ folder

3. Edit gene_expression_heatmap.R to point to your files (if needed)

4. Run in R or RStudio:

```r
source("gene_expression_heatmap.R")
```

---
## Notes

- The script expects your data files to contain at least:

  - Symbol (gene symbol)

  - log2_Fold_Change

  - p_adjusted_value (for significance filtering)

- The gene list file should contain a column named Gene

- Heatmaps are row-normalized for visualization, highlighting expression patterns

---

## Acknowledgments

This script was developed for visualizing gene expression patterns in a single-cell RNA-seq dataset. If you use or adapt this code, consider citing this repository or linking back.
