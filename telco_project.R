# Load Required Libraries
library(caret)
library(class)
library(rpart)
library(e1071)
library(nnet)
library(ggplot2)

# Load & Clean Data
Data <- na.omit(read.csv(file.choose(), stringsAsFactors = FALSE))
View(Data)

# Convert specified columns to factors
factor_columns <- c("gender", "Contract", "SeniorCitizen", "Partner", "Dependents", 
                    "PhoneService", "MultipleLines", "InternetService", 
                    "OnlineSecurity", "OnlineBackup", "DeviceProtection", 
                    "TechSupport", "StreamingTV", "StreamingMovies", 
                    "PaperlessBilling", "PaymentMethod")

Data[factor_columns] <- lapply(Data[factor_columns], as.factor)

# Create new features
Data$TenureGroup <- cut(Data$tenure,
                        breaks = c(0, 12, 24, 36, 48, 60, Inf),
                        labels = c("0-12 Months", "1-2 Years", "2-3 Years", "3-4 Years", "4-5 Years", "5+ Years"))
Data$IsLongTerm <- ifelse(Data$Contract == "Month-to-month", 0, 1)
Data$EstimatedTotalCharges <- Data$MonthlyCharges * Data$tenure

# Scale numerical columns
Data$MonthlyCharges <- scale(Data$MonthlyCharges)
Data$tenure <- scale(Data$tenure)

# Split the data
set.seed(123)  
trainIndex <- createDataPartition(Data$Churn, p = 0.7, list = FALSE)
trainData <- Data[trainIndex, ]
testData <- Data[-trainIndex, ]

#churn as a factor
trainData$Churn <- as.factor(trainData$Churn)


# Train and Evaluate Models
models <- list(
  KNN = caret::train(Churn ~ ., data = trainData, method = "knn", tuneGrid = data.frame(k = 5)),
  DecisionTree = rpart(Churn ~ ., data = trainData, method = "class"),
  NaiveBayes = naiveBayes(Churn ~ ., data = trainData),
  ANN = nnet(Churn ~ ., data = trainData, size = 5, linout = FALSE, decay = 0.1)
)

accuracy_data <- data.frame(Model = character(), Accuracy = numeric(), 
                            F1_Score = numeric(), Precision = numeric(), Recall = numeric())

# Loop through each model, make predictions, and calculate metrics
for (model_name in names(models)) {
  if (model_name == "DecisionTree") {
    pred <- predict(models[[model_name]], testData, type = "class")
  } else if (model_name == "ANN") {
    pred <- predict(models[[model_name]], newdata = testData, type = "class")
  } else {
    pred <- predict(models[[model_name]], newdata = testData)
  }
  
  # Convert predictions and actuals to factors with the same levels
  pred <- factor(pred, levels = c("Yes", "No"))
  testData$Churn <- factor(testData$Churn, levels = c("Yes", "No"))
  
  # Calculate metrics
  cm <- confusionMatrix(pred, testData$Churn)
  accuracy <- cm$overall['Accuracy']
  f1 <- cm$byClass['F1']
  precision <- cm$byClass['Precision']
  recall <- cm$byClass['Recall']
  
  # Store metrics in data frame
  accuracy_data <- rbind(accuracy_data, data.frame(Model = model_name, Accuracy = accuracy, 
                                                   F1_Score = f1, Precision = precision, Recall = recall))
}

# Print accuracy results
print(accuracy_data)

# Identify the best model based on Accuracy
best_model <- accuracy_data[which.max(accuracy_data$Accuracy), "Model"]
cat("The best model based on accuracy is:", best_model, "\n")

# Plot the Accuracies and Metrics
ggplot(accuracy_data, aes(x = Model)) +
  geom_bar(aes(y = Accuracy, fill = Model), stat = "identity") +
  geom_point(aes(y = F1_Score, color = "F1 Score"), size = 3) +
  geom_point(aes(y = Precision, color = "Precision"), size = 3) +
  geom_point(aes(y = Recall, color = "Recall"), size = 3) +
  labs(title = "Model Performance Comparison", y = "Metrics", x = "Model") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_color_manual(values = c("F1 Score" = "red", "Precision" = "blue", "Recall" = "green"))
