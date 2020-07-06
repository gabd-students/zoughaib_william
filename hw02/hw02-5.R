### WIlliam Zoughaib
### Part 5:Data Frames
### Lets Get this Bread

### 5.1 Data Frames
# find chickwts data frame along with three others
class(chickwts)
class(CO2)
class(Formaldehyde)
class(USArrests)

### 5.2 Viewing Data frames
#load iris data
data(iris)
#display iris
iris
# display first 10 rows
head(iris, n=10)
# display last 10 rows
tail(iris, n=10)
#display dimensions of iris
dim(iris)
#display structure of iris data
str(iris)

### 5.3 Extracting elements from a data frame
# find 101 row in 4 column using numbers
iris[101,4]
# display 6 rows with all 5 columns
iris[1:6,1:5]
# display rows 48-52 of fourth column by name
iris[48:52,"Petal.Length"]
# display data of iris using $ and Sepal.Width
iris$Sepal.Width
#optional challenge
iris[50:51,"Species"]
# I cannot figure this out


### 5.4 Extracting elements from Boolean vectors
# Extract rows where sepal length less than or equal to 5.5. Save the result.
short_sepal_iris <- iris$Sepal.Length <= 5.5
short_sepal_iris
s_s_lengths <- iris$Sepal.Length[short_sepal_iris]
s_s_lengths 
#obtain minimum and maximum of sepal lengths
min(s_s_lengths)
max(s_s_lengths)
# Display rows where sepal width is less than 3.2 AND species is setosa.
wide_sepal_iris <- iris$Sepal.Width < 3.2 & iris$Species== "setosa"
wide_sepal_iris
iris[wide_sepal_iris,]
# Display rows where sepal width is less than 2.5 OR petal width is greater than 2.0.
narrow_sepal_iris <- iris$Sepal.Width < 2.5 | iris$Petal.Width > 2.0
narrow_sepal_iris
iris[narrow_sepal_iris,]


### 5.5 Use subset to extract data from a data frame
#find data for petal length between >= 4 and <=5
subset(iris, Petal.Length >=4 & Petal.Length <=5)
# find data for sepal length < 5.2 but versicolor
subset(iris, Sepal.Length < 5.2 & Species== "versicolor")


### 5.6 Sort Data Frame by order
#Sort from shortest to longest Sepal length
sort_order <- order(iris$Sepal.Length)
iris[sort_order,"Sepal.Length"]
#find species and sort petal width in decreasing order
sort_order <- order(iris$Petal.Width, decreasing = TRUE)
iris[sort_order,]


### THE END