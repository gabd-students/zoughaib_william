### William Zoughaib
### Assignment Part 4 Vectors
### Lets get this bread


### 4.1 What is a factor
# Genotype can be heterozygous or homozygous
# genotype of 6 individuals
genotype_vector <- c("Heterozygote", "Heterozygote", "Homozygote", "Heterozygote", "Homozygote", "Heterozygote")
genotype_factor <- factor(genotype_vector)
genotype_factor
# make a character vector for the bees visiting the single flower
bee_visitors_vector <-  c("kirbiellus", "kirbiellus", "flavifrons", "kirbiellus", "bifarius", "flavifrons", "kirbiellus")
# make a bee_visitor_factor from the bee_visitors_vector
bee_visitor_factor <- factor(bee_visitors_vector)
#run bee_visitor_factor
bee_visitor_factor


### 4.2 Factor Types
# create proboscis_vector
proboscis_vector <- c("long","long","intermediate","long","short","intermediate","long")
# create proboscis_factor from long to short
proboscis_factor <- factor(proboscis_vector, ordered = TRUE, levels = c("long","intermediate","short"))
# run proboscis_factor
proboscis_factor


### 4.3 Summarizing a factor
# run summary of bee_visitors_factor
summary(bee_visitor_factor)
# run summary of proboscis_factor
summary(proboscis_factor)


### 4.4 Extracting from and Comparing Factors
# use bee_visitor_factor and select non "kirbiellus" elements
bee_visitor_factor
bee_visitor_factor != "kirbiellus"
# use bee_visitor_factor and select 2 & 4-6 elements
bee_visitor_factor[c(2,4:6)]
# in proboscis factor, is 1st element longer than last element
proboscis_factor
p_ffirst <-proboscis_factor[1] 
p_flast <-proboscis_factor[7]
p_ffirst > p_flast
p_ffirst==p_flast
# challenge using (length)
length(proboscis_factor["last"])
length(proboscis_factor)
proboscis_factor[7]


### THE END