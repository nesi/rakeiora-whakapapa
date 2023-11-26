configfile: "config.yaml"

outdir         = config["outdir"]
logdir         = config["logdir"]
singularity_R  = config["singularity_R"]
pedigree_file  = config["pedigree_file"]
phenotype_file = config["phenotype_file"]
METHODS        = config["METHODS"]
Rscript_file   = config["Rscript_file"]
inputvcf_file  = config["inputvcf_file"]

#workflow
rule all:
    input:
        expand(outdir + '{method}.txt', method= METHODS)

rule rscript:
    input:
        Rfile  = Rscript_file
        ,PED   = pedigree_file
        ,VCF   = inputvcf_file
        ,PHENO = phenotype_file
    output:
        out = outdir + "{method}.txt"
    log:
        out = logdir + "{method}.stderr"
    container:
        singularity_R
    shell:
        "Rscript \
            {input.Rfile} \
            {wildcards.method} \
            {input.PED} \
            {input.VCF} \
            {input.PHENO} \
            NA \
            > {output.out} 2>{log.out}"
