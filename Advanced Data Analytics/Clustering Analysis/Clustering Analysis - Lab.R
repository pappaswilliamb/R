### Clustering Analysis in R

library(dplyr)

movie = read.csv("movie.csv")


## Distance Calculation: Normalization

normalize = function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
  }

# Example
normalize(c(1, 2, 3, 4, 5))


# Apply This Function to the Data (Method 1)

movie_normalized = movie %>%
  mutate(Action_n = normalize(Action),
         Comedy_n = normalize(Comedy),
         Drama_n = normalize(Drama),
         Horror_n = normalize(Horror),
         Sci.Fi_n = normalize(Sci.Fi))


# Apply This Function to the Data (Method 2)

library(dplyr)

# Apply normalize() Function to Column #2 - #6, Use dplyr
movie_normalized = movie %>%
  mutate_at(c(2:6), normalize)


## Distance Calculation: Distance Matrix

# install.packages("stats")
library(stats)

distance_matrix = dist(movie_normalized[, 2:6], method = "euclidean")

# To View the Resultant Distance Matrix, Run the Following:
View(as.matrix(distance_matrix))


## Hierarchical Clustering

hierarchical = hclust(distance_matrix, method = "ward.D")

# Dendrogram
plot(hierarchical, labels = movie_normalized$Name)

# Show the 3-Cluster Solution
plot(hierarchical, labels = movie_normalized$Name)
rect.hclust(hierarchical, k = 3)

# Use the cutree() Function to "Cut" the Dendrogram
movie_normalized$cluster = cutree(hierarchical, k = 3)

# Check the Cluster Centroids
movie_normalized %>% group_by(cluster) %>%
  summarise_at(c(2:6), mean)


## K-Means Clustering

kcluster = kmeans(movie_normalized[, 2:6], centers = 3)

# Check the Cluster Centroids
kcluster$centers

# Check Which Entities Belong to Which Cluster
kcluster$cluster

# Plot the SSE Curve to Find the Appropriate Cluster Number
SSE_curve <- c()
for (n in 1:10) {
  kcluster = kmeans(movie_normalized[, 2:6], n)
  sse = kcluster$tot.withinss
  SSE_curve[n] = sse
  }

# Plot the SSE Against the Number of Clusters
plot(1:10, SSE_curve, type = "b")