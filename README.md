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


