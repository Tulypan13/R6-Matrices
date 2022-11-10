
# Matrices: create a matrix with 4 rows and 7 columns with numbers from 1 to 28,
# (because 4x7=28) ordered by column
matrix(1:28, nrow = 4, ncol = 7, byrow=FALSE)
# Or simply:
matrix(1:28, 4)

## What is the byrow parameter for?
## The same matrix can be generated in different ways (ordered by rows)
month_matrix <- matrix(1:28,ncol=7, byrow=T); month_matrix

## The length is the total number of elements:
typeof(month_matrix)
class(month_matrix)
length(month_matrix)
names(month_matrix)
attributes(month_matrix)
# Look how R prefers to order things by column!
str(month_matrix)

# Besides, it has some "proper" functions:
nrow(month_matrix)
ncol(month_matrix)
dim(month_matrix)
is.matrix(month_matrix)

# Access the element in the 2nd row and 3rd column
month_matrix[2,3]
# Access the 3rd row
month_matrix[3,]
# Or generate sub-matrices:
month_matrix[2:3,]
month_matrix[2:3,2:3]


## Naming dimensions (you can name them when you construct the matrix)
## Rows:
rownames(month_matrix) <- c('week_1','week_2','week_3', 'week_4')
month_matrix
## Check the name of the rows
rownames(month_matrix)
## Columns (I do not want to type day by day... I'm lazy):

## In what language is my System? Get Locale-Specific Information for time
## when parsing or writing dates
Sys.getlocale("LC_TIME")
## ISOdate(year, month, day) function to create data-times. 
## Converts numeric representation to date-times.
ISOdate(1, 1, 1)
weekdays(ISOdate(1, 1, 1))


## I will change the locale of R in R itself to English.
Sys.setlocale("LC_TIME", "en_US")
## And it is changed; now we have the appropriate words for the days of the 
## weeks and the months.
Sys.getlocale("LC_TIME")
## Then,
ISOdate(1, 1, 1)
weekdays(ISOdate(1, 1, 1))

## Store all days of the week
days <- weekdays(ISOdate(1, 1, 1:7)); days
colnames(month_matrix) <- days
## Check the name of the columns:
colnames(month_matrix)
month_matrix

attributes(month_matrix)
## Compare:
attributes(matrix(1:28,4))
## Or:
str(month_matrix)
## Compare:
str(matrix(1:28,4))

## Access by label
month_matrix
month_matrix[,'Friday']
# Try this (OPS!):
month_matrix$week_1

# Transpose a matrix:
month_matrix_t <- t(month_matrix)
attributes(month_matrix_t)
attributes(month_matrix)

## diag() extract diagonal from a matrix or create a diagonal matrix:
diag(month_matrix)
## Also, one can create diagonal matrices:
diag(1, nrow =3)
## and with you, the identity matrix of rank 3.

## Methods to create matrices:
v1 <- 1:3; v2 <- 4:6
## Join (bind) vectors or matrices by columns:
m1 <- cbind(v1,v2);m1
## Join (bind) vectors or matrices by rows:
m2 <- rbind(2:4,5:7);m2

## Add new rows and columns:
m1
m1 <- cbind(m1,7:9) ; m1
m1 <- cbind(m1,v3 = 7:9) ; m1

## Eliminate the 3rd column:
m1 <- m1[,-3];m1
## Eliminate 2 rows:
m1 <- m1[-c(1,3),];m1
m1
is.vector(m1)
is.vector(m2)
is.matrix(m1)
is.matrix(m2)
# We have transformed a matrix into a vector!

## Add 2 rows
rbind(m1,seq(3,6,3),seq(4,7,3));m1
m1 <- rbind(m1,seq(5,7));m1
m2
m1 == m2


## Arithmetic operations on matrices:
m1 <- matrix(nrow=2, 1:4, byrow = T);m1
m1+1
m1+m1
2*m1
m1+m1 == 2*m1

# Rescpect lengths:
m1+1:5
m1+1:4

m1

## and if I would like the matrix  2  4  adding m1 and a vector?
##                                 4  6
m1+1:2
# I try to sum the vector as a row vector:
v1 <- t(1:2);v1
is.vector(v1)
is.matrix(v1)
# But I can not sum them. Matrices have rules for operating them.
m1+v1
## Is the same to do this:
v2 <- matrix(1:2);v2
m1+v2
m1
## The recursive way of operating matrices with vectors whose length is a 
## multiple of the dimension of the matrix does not work between matrices.
## Solve the excercise adding matrices:
m1+rbind(1:2,c(1,2))


# Matrix multiplication:
m1 <- matrix(1:4, nrow=2, ncol=2, byrow=T);m1
m2 <- matrix(1:6, nrow=2, ncol=3, byrow=T);m2
# I can multiply (2,2)x(2,3) matrices:
m1%*%m2
# But I can not multiply (2,3)x(2,2) matrices:
m2%*%m1
## Do you remember the infix operators!?!?

# Be careful with these functions!!!
# The crossprod function
m1
m2

## Now, t(2,2)=(2,2) so I can do:
crossprod(x = m1, y = m2)
## But is not the same than:
m1%*%m2
## Because crossprod is equivalent to:
t(m1)%*%m2
t(m1)%*%m2 == crossprod(x = m1, y = m2)

## I can also do:
crossprod(x = m2, y = m1)
## Because this is equivalent to transpose the first matrix,
## t(2,3)=(3,2) and I can multiply by a (2,2) matrix:
t(m2)%*%m1

# Also you have the tcrossprod function
## Now the transpose is in the second parameter, so m1 is useless
t(m2)
# So I must define a new matrix with the proper dimensions. For example,
m3 <- matrix(1:6,ncol=3,byrow=TRUE);m3
tcrossprod(m3,m2)
## Which is equivalent to:
m3%*%t(m2)


# System of equations:
# From diapo 7.
equations <- matrix(c( c(1,2), c(-2, 1) ), ncol = 2, nrow = 2, byrow = T)
equations

independent <- c(10, 0); independent

solve(equations, independent)



# apply() function:
## Get the sum of the columns of a matrix
m <- matrix(5:14, nrow = 5, ncol = 2);m
apply(X=m, MARGIN=2, FUN=sum)

## Or the sum of the rows
row_sum <- apply(m, 1, sum)
row_sum
class(row_sum)
## Which is equivalent to:
c(sum(m[,1]), sum(m[,2]))



# lapply()
## Special case of apply() design for lists.
m.2 <- matrix(1:12, ncol = 3)

my.list = list(m.2, m); my.list

prod_list = lapply(my.list, FUN = prod);prod_list

## Checks:
prod_list[[1]] == factorial (12)
class(prod_list)

## Check this!!! :O Let us introduce data frames!

## This data set provides measurements of the diameter, height (in feet) and volume 
## of timber in 31 felled black cherry trees. Note that the diameter (in inches)
## is erroneously labelled Girth in the data.

trees
trees_mean <- lapply(X = trees, FUN = mean);trees_mean
class(trees_mean)
class(trees)

## This coincides with applying the mean() function to each of the columns.
## Let us see only the height:
mean(trees$Height)
## Let us convert feet to meters: 
## 1 feet = 0.3048 mts
mean(trees$Height)*0.3048


# sapply()
## The output is a matrix or a vector.
my.list
sapply(my.list, sum)
## A vector in this case:
class(sapply(my.list, sum))
## Be free to play with this!


# tapply()
## Check this manner of adding odd and even numbers separately:
v.num <- c(10:20)v.num

v.fact <- c("PAR", "IMPAR", "PAR", "IMPAR", "PAR", "IMPAR",
            "PAR", "IMPAR", "PAR", "IMPAR", "PAR"); v.fact

tapply(v.num, v.fact, sqrt)
tapply(v.num, v.fact, sum)

# There is also mapply(), check how it works!