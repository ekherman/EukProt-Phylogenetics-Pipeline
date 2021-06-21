# EukProt Phylogenetics Pipeline

**Author:** Emily Herman

**Date:** 21 June 2021

**Version:** 1.0

## Synopsis

This is a Snakemake workflow that takes BUSCO single copy orthologues
from [EukProt taxa](https://figshare.com/articles/dataset/EukProt_a_database_of_genome-scale_predicted_proteins_across_the_diversity_of_eukaryotic_life/12417881)
and from user-supplied eukaryote(s) of interest, and creates a concatenated
supermatrix of all shared orthologues. This supermatrix can be used to
phylogenetically place the organisms of interest in the eukaryotic tree.

For more information about EukProt, see [EukProt: a database of genome-scale predicted proteins across the diversity of eukaryotic life](https://www.biorxiv.org/content/10.1101/2020.06.30.180687v1.full.pdf).

## Sections

[Installation](#installation)

[Setup](#setup)

[Running EukProt Phylogenetics Pipeline](#running-eukprot-phylogenetics-pipeline)

[Output](#output)

## Installation

The following programs are required by the pipeline:
- [Python 3.7+](https://www.python.org/downloads/)
    - [pandas](https://pypi.org/project/pandas/)
    - [cython](https://pypi.org/project/Cython/)
- [Perl v5+](https://www.perl.org/)
- [Snakemake 5.8+](https://snakemake.readthedocs.io/en/stable/)
- [HMMer v.3+](http://hmmer.org/)
- [ClipKIT](https://jlsteenwyk.com/ClipKIT/)

    *Clipkit must be installed in a Python virtual environment, and its
path must be included in* `config/eukprot_phylogenetics.config.yaml`.
*See ClipKIT installation instructions for more details.*
- [FASconCAT-G](https://github.com/PatrickKueck/FASconCAT-G)
- The HMM files from the BUSCO eukaryota_odb10 lineage

### Downloading the EukProt Phylogenetics Pipeline

To download the workflow, either download and extract the zip file, or
run the following:

```
git clone https://github.com/ekherman/EukProt-Phylogenetics-Pipeline.git
```

## Setup

Edit the configuration file `config/eukprot_phylogenetics.config.yaml`.
The following paths are required:

1. Current working directory (default: `EukProt-Phylogenetics-Pipeline`)
2. Directory containing EukProt BUSCO protein files. These must have the
filename structure `{BUSCO ID}.{EukProt ID}.fasta`.
3. Directory containing the BUSCO protein files from user data that will
 be added to the EukProt backbone tree. These must have the filename
structure `{BUSCO ID}.{assembly name}.fasta`. The assembly name may
contain alphanumeric characters and underscores (**NOT periods**).
4. Desired name of the output directory.

5. Directory containing the BUSCO HMM files (default:
`eukaryota_odb10/hmms/`).
6. Path to the hmmalign program. If the program is in your PATH, leave
this value as `hmmalign`.
7. Path to the ClipKIT virtual environment.
8. Path to the FASconCAT-G perl script `FASconCAT-G_v1.05.pl`.

## Running EukProt Phylogenetics Pipeline

To run the pipeline:

```
snakemake -s workflow/eukprot_phylogenetics.sm
```

The current version of this pipeline does not submit jobs to a cluster.
If memory usage is a concern, the pipeline can be run on an interactive
computing node.

## Output

During processing, a number of intermediate files are created in `tmp/`
directories within the input directories specified in the config file.

In the output directory specified in the config file, the following files
will be created

 - `fasconcatg/[N]x[M].fas`: the final supermatrix with `N` species and
`M` genes.
- `fasconcatg/{gene_id}.fas`: the trimmed alignment for each gene,
following character replacement

All other files are intermediate files and may be removed after running
the workflow to completion.
