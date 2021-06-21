# EukProt Phylogenetics Pipeline

**Author:** Emily Herman

**Date:** 21 June 2021

**Version:** 1.0

## Sections

[Installation](#installation)

[Setup](#setup)

[Running EukProt Phylogenetics Pipeline](#running-eukprot-phylogenetics-pipeline)


## Installation

The following programs are required by the pipeline:
- [Python 3.7+](https://www.python.org/downloads/)
    - [pandas](https://pypi.org/project/pandas/)
    - [cython](https://pypi.org/project/Cython/)
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

1. Current working directory (default: `eukprot_phylogenetics`)
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