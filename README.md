This repo is for trying out normalization methods for the [`fbseq`](https://github.com/wlandau/fbseq). 

# Run the workflow

This repo uses the [`workflowHelper`](https://github.com/wlandau/workflowHelper) package, so the steps to run are as follows.

1. Run the script `workflow.R` to create a [`Makefile`](https://www.gnu.org/software/make/).
2. Optionally, configure simulation parameters with the small functions in `config.R`.
3. Run `make`. If you're on a cluster, you can do this through `slurm.sh` for [Slurm](https://en.wikipedia.org/wiki/Slurm_Workload_Manager) clusters or 
`pbs.sh` for [PBS](https://en.wikipedia.org/wiki/Portable_Batch_System) clusters.
