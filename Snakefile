# /logs and /results will be copied to jupyter hub
outdir         = "results/"
logdir         = "logs/"
resourcedir    = "resources/"
pedigree_file  = "alea/simped103id"
phenotype_file = "alea/simdatafull"
output_file    = outdir + "snakedevout.txt"
            
# inputvcffile should be the filename defined in the workflow input in Rakeiora.
# Rakeiora will create this multi-sample vcf.gz file from your selections.
inputvcffile   = resourcedir + "input.vcf.gz"
            
singularity_R  = "/shared/singularities/whakapapa_1.0.sif"
Rscript_file   = "GBLUPsnakemakeMay23.R"

#workflow
rule rscript:
    input:
        Rfile  = Rscript_file
        ,PED   = pedigree_file
        ,VCF   = inputvcffile
        ,PHENO = phenotype_file
    output:
        out = output_file
    container:
        singularity_R
    shell:
        "Rscript {input.Rfile} GBLUP {input.PED} {input.VCF} {input.PHENO} NA > {output.out} 2>&1"
