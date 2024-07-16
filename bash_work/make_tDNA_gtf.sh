#! /usr/bin/bash



# echo "T-DNA sequence" >> gtf_sequence.tmp

# cut -f1 T_DNA_metadata.txt |  grep -Po "(?<=\().*" | grep -Po ".*(?=\))" > gtf_source.tmp

# Seqname column. Usually chromosome. I'll just call it "T-DNA sequence"
sequence="pDE00.0201_resequenced"

times=19

counter=1

while [ $counter -le $times ]; do
    echo -e $sequence
    ((counter++))
done > tmp/gtf_sequence.tmp

# Make source column
source="DandekarLab"

times=19

counter=1

while [ $counter -le $times ]; do
    echo -e $source
    ((counter++))
done > tmp/gtf_source.tmp

# Make feature column
feature="gene"

times=19

counter=1

while [ $counter -le $times ]; do
    echo -e $feature
    ((counter++))
done > tmp/gtf_feature.tmp

# Start and end sites
cut -f1 T_DNA_metadata_resequenced.txt |  grep -Po "(?<=^\").*(?=\()" > tmp/start_end.tmp

cat tmp/start_end.tmp | grep -Po "^.*-" | grep -Po ".*(?=-)" | sed 's/,//g' > tmp/gtf_start.tmp

cat tmp/start_end.tmp | grep -Po "\-.*$" | grep -Po "(?<=\-).*" | sed 's/,//g' > tmp/gtf_end.tmp

# Make score column
score="."

times=19

counter=1

while [ $counter -le $times ]; do
    echo -e $score
    ((counter++))
done > tmp/gtf_score.tmp

# Make strand column
strand="+"

times=19

counter=1

while [ $counter -le $times ]; do
    echo -e $strand
    ((counter++))
done > tmp/gtf_strand.tmp

# Make frame column
frame="."

times=19

counter=1

while [ $counter -le $times ]; do
    echo -e $frame
    ((counter++))
done > tmp/gtf_frame.tmp

# Make attributes. Not sure if even useful

cut -f2 T_DNA_metadata_resequenced.txt | sed '1d' | sed "s/ \(-s\)/\1/g" | sed 's/[[:space:]]*$//g' | sed 's/ /-/g' | sed "s/’/'/g" | sed "s/-\(M\)/\1/g"  > tmp/gtf_awk_attributes.tmp

# Appends "gene_id " 'attribute'; "gene " 'attribute'
awk -F'\t' '{print "gene_id \"" $0 "\"; gene \"" $0 "\""}' tmp/gtf_awk_attributes.tmp > tmp/gtf_attribute.tmp

paste -d'\t' tmp/gtf_sequence.tmp tmp/gtf_source.tmp tmp/gtf_feature.tmp tmp/gtf_start.tmp tmp/gtf_end.tmp tmp/gtf_score.tmp tmp/gtf_strand.tmp tmp/gtf_frame.tmp tmp/gtf_attribute.tmp > Results/J1_1A_TDNA_resequenced.gtf

cat Results/J1_1A_TDNA_resequenced.gtf

cp Results/J1_1A_TDNA_resequenced.gtf /mnt/box/ALAB/scp_rsync_barbera_downloads/BAM_BAI_J1_1A_1A/bwa/
