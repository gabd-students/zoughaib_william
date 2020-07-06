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
bee_visitor_factor