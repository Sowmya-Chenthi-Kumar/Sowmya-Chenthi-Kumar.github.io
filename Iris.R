# First lets load the required dataset:


data("iris")
head(iris)
new_data<- iris[,-5]
head(new_data)
# Creating a correlation matrix to understand if there are any dependencies:
cor(new_data)

# Create a scatterplot matrix:
attach(iris)
plot(~iris$Sepal.Length+iris$Petal.Length+iris$Sepal.Width+iris$Petal.Width)

# From the scatter plot we can see that the data is having certain categorical stuff

library(tree)
iris_tree=tree(iris)
plot(iris_tree)
text(iris_tree)

# Now we can use crossvalidation to chcek if the tree requires any pruning,
# the tree has 7 terminal nodes 

cv_iris<-cv.tree(iris_tree,K=20)
plot(cv_iris,type = "b")

# As the least value is at 7 it is safe to say that our tree does not require
# any pruning

# Finding the required MSE values from this dataset:
min(cv_iris$dev)

# The MSE value is pretty low and we can say that the tree model
# is a pretty good model for our analysis

# Next we can see how this model can be improvised and that is through 
# Bagging and Random forest:

# Bagging process:
library(randomForest)
iris_bag<-randomForest(iris$Species~. , data = iris, mtry=4)
iris_bag

# From the summary we can see that the OOB error rate is very less 4.67%
# which is an appreciable reduction
# Random forest can give much more stable results because of the 
# larger variety it poses in the model 

# Random Forest:
iris_rf<-randomForest(iris$Species~. , data = iris, mtry=2)
iris_rf

# There is a slight increase in the OOB error rates to 6% 
# However these are the most believable error rates in the long run 

library(caret)
install.packages("caret")

varImpPlot(iris_rf)

# From the variable importance plot we can see that the Petal.length 
# and the petal.Width play a major role in the classification process
# This result is insync with the scatter plot matrix which we have seen 
