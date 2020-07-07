### William Zoughaib
### Part 6 Lists

### 6.1 Introduction to Lists
#n/a


### 6.2 Create a List
# create numeric_vector for 1-6
numeric_vector <- 1:6
numeric_vector
# create logical vector with TRUE, FALSE x 4
logical_vector <- rep(c(TRUE, FALSE),4)
logical_vector
# create letter matrix for first 9 letters with 3 columns
letter_matrix <- matrix(LETTERS[1:9], ncol=3)
letter_matrix
# use first 10 elements from chickwts data frame
chicks_df <- chickwts[1:10,]
chicks_df
# use numbers, boolean, letters, chicks respectively from the above scripts to create a list
the_list <- list(numbers=numeric_vector,boolean=logical_vector,letters=letter_matrix,chicks=chicks_df)
#run the_list
the_list
# run str() for the_list
str(the_list)


### 6.3 Extract Elements from a List
## Assignment instructions
# create hb vector using chickswts and first 10 elements
chicks_hb <- chickwts$weight[1:10]
chicks_hb
# create linseed vector but use elements 11-20
chicks_ls <- chickwts$weight [11:20]
chicks_ls
# create a list using t.test for above vectors
chicks_t <- t.test(chicks_hb,chicks_ls, var.equal = TRUE)
#run str() on chicks_t
str(chicks_t)
#display numeric value for (t.test) using statistic
chicks_t$statistic
#display p.value for chicks_t using p.value
chicks_t$p.value
#display lower confidence interval for chicks_t
chicks_t$conf.int[1]
#display upper confidence interval for chicks_t
chicks_t$conf.int[2]
# create text string where whew <- "I did it"
whew <- "I did it!"
whew
whew
whew