### William Zoughaib

### Matrices

### 3.1 What's a Matrix
first_matrix <- matrix(1:9, byrow = TRUE, nrow = 3)
first_matrix
?matrix
first_matrix <- matrix(1:9, byrow = FALSE, nrow = 3)
first_matrix
first_matrix <- matrix(1:9, byrow = TRUE, nrow = 3)
first_matrix

# run matrix with 11:30 and 4 rows by row
second_matrix <- matrix(11:30, byrow=TRUE, nrow=4)
second_matrix
# run matrix with 11:30 and 5 columns by column
second.2_matrix <- matrix(11:30, byrow=FALSE, ncol=5)
second.2_matrix

### 3.2 Construct a Matrix
chick_weights <- chickwts$weight[c(1:20, 23:32)]
chick_weights
#Create column matrix for chick_weights diet
three_diets_matrix <- matrix(chick_weights, byrow=FALSE, ncol=3)
# display data for column matrix
three_diets_matrix

### 3.3 Name the Column and Rows
# Name the columns horsebean, linseen, soybean & rows
diet_names_vector <- c("horsebean","linseen","soybean")
colnames(three_diets_matrix) <- diet_names_vector
three_diets_matrix
# Name the rows
chicknumber_name_vector <- c(paste("Replicate", 1:10))
rownames(three_diets_matrix) <- chicknumber_name_vector
three_diets_matrix

### 3.4 Calculation on Matrices
# use rowSums for matrix created from 11:30
rowSums(first_matrix)
# find mean weight for each diet in the columns
colMeans(three_diets_matrix)
mean_weights <- colMeans(three_diets_matrix)
#add the values to mean_weights
mean_weights
# find mean weight for all 30 chicks???
mean(three_diets_matrix)
chick_weights

mean(chick_weights)

### 3.5 Add a column with another diet type
#run first_matrix with 1:9
first_matrix <- matrix(1:9, byrow = TRUE, nrow = 3)
first_matrix
row_names_vector <- c("Row 1","Row 2","Row 3")
col_names_vector <- c("Col 1", "Col 2", "Col 3")
rownames(first_matrix) <- row_names_vector
colnames(first_matrix) <- col_names_vector
first_matrix
# add another vector with 10:12
new_row <- c(10:12)
# add new row to first_matrix
first.1_matrix <- rbind(first_matrix,new_row)
#data for first.1_matrix
first.1_matrix
rownames(first.1_matrix)[4] <- "Row 4"
first.1_matrix

#add 10 chicks from casein diet 
casein_diet_weights <- chickwts$weight[60:69]
#use cbind to add this data to three_diets matrix
four_diets_matrix <- cbind(three_diets_matrix,casein_diet_weights)
four_diets_matrix 
#too much info, reattempt to save time
casein <- chickwts$weight[60:69]
four_diets_matrix <- cbind(three_diets_matrix, casein)
four_diets_matrix
# calculate mean weight sfor each of the four diets
colMeans(four_diets_matrix)

### 3.6 Selecting Matrix Elements
# in first matrix, select first row second column
first.1_matrix[1,2]
# in second matrix, select rows 1:3 and 2:4
second.2_matrix[1:3,2:4]
second_matrix[1:3,2:4]

# in four_diets matrix, select linseed column (2)
four_diets_matrix[,2]
# in four_diets matrix, select soybean by name
four_diets_matrix[,"soybean"]
# in four_diets matrix, select 9th row, by row number
four_diets_matrix[9,]
# in four_diets matrix, select 3rd row by row name
four_diets_matrix["Replicate 3",]
# in four_diets matrix, find element in fifth row in the horsebean column
four_diets_matrix["Replicate 5","horsebean"]

### 3.7 A little arithmetic with matrices
# convert four_diets_matrix weight from grams to ounces
four_diets_ounces <- 0.035 x four_diets_matrix
four_diets_ounces <- 0.035 * four_diets_matrix
four_diets_ounces
# find logarithm of each weight (grams) in four_diets_matrix
log(four_diets_matrix)
#find logarithm of each weight (ounces) in four_diets_ounces
log(four_diets_ounces)
# find dimension of four_diets_matrix
dim(four_diets_matrix)
# find length of four_diets_matrix
length(four_diets_matrix)

###THE END