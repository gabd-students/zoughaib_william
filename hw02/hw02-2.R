### William Zoughaib
##### Part 2 Vectors attempt 2
### Save your data.  Lost data from 2.1:2.6
### You will lose it if you reset computer.
### Bad News Bear
### 2.1 Vectors explained
### 2.2 Vector Types
# add alphabet vector script
alphabet <- c("A","B","C","D","E","F")
alphabet
# add integer vector script
integer <- c(1,2,3,4,5,6)
integer
# add logical vector script
logical_vector <- c(FALSE,FALSE,TRUE)
logical_vector

### 2.3 Biological Vectors
# add cultures_without_pplo vector script
cultures_without_pplo <- c(4.6,4.8,5.1,5.5,5.8)
cultures_without_pplo
# add cultures_with_pplo vector script
cultures_with_pplo <- c(4.6,4.7,4.8,4.9,4.8)
cultures_with_pplo

### 2.4 Name your Vectors
# add days_sampled vector script
days_sampled <- c("Day 0","Day 2","Day 4","Day 6", "Day 8")
days_sampled
names(cultures_without_pplo) <- days_sampled
names(cultures_with_pplo) <- days_sampled
cultures_without_pplo
cultures_with_pplo

### 2.5 Calculation with Vectors
# find max cultures_without_pplo
max(cultures_without_pplo)
max_without_pplo <- 5.8
# find max cultures_with_pplo
max(cultures_with_pplo)
max_with_pplo <- 4.9
# find min cultures_without_pplo
min(cultures_without_pplo)
min_without_pplo <- 4.6
# find min cultures_with_pplo
min(cultures_with_pplo)
min_with_pplo <- 4.6
# calculate cell counts without pplo
cell_counts_without_pplo <- 10^cultures_without_pplo
cell_counts_without_pplo
# calculate cell counts with pplo
cell_counts_with_pplo <- 10^cultures_with_pplo
cell_counts_with_pplo 

### 2.6 Extract Individual elements from a vector
# find 3rd element of cultures_without_pplo
cultures_without_pplo[3]
# select odd numbered elements from cell_counts_with_pplo
cell_counts_with_pplo[c(3,5)]
# select day 2 and day 4 from cultures_with_pplo
cell_counts_with_pplo[c("Day 2","Day 4")]

### 2.7 Extraction by Logical Comparison
### Where I stopped last
# find integers less than or equal to 5
ten_integers <- c(1:10)
low_integers <- ten_integers<=5
# what is Boolean vector for low_integers
low_integers

# find logical vector for cell_counts_without_pplo > 100,000
high_cell_counts_without_pplo <- cell_counts_without_pplo > 100000
high_cell_counts_without_pplo
# store vector for high_cell
cell_counts_without_pplo[high_cell_counts_without_pplo]
# use above vector for cultures_without_pplo
cultures_without_pplo[high_cell_counts_without_pplo]
# find vector for cell_counts_with_pplo for logical vector between 50000 and 75000
cell_counts_with_pplo_range <- cell_counts_with_pplo<50000 & cell_counts_with_pplo>75000
cell_counts_with_pplo_range
# messed up range.  change signs
cell_counts_with_pplo_range <- cell_counts_with_pplo>50000 & cell_counts_with_pplo<75000
cell_counts_with_pplo_range


### THE END
