<h1 align="center">Customer Churn Prediction</h1>

<p align="center">
  <strong>A machine learning project using R to predict customer churn and compare model performances.</strong>
</p>

---

## 📖 Project Description
This project aims to predict customer churn using historical data of a telecom company. Churn prediction helps businesses retain customers by identifying those at risk of leaving. The project involves building and evaluating various machine learning models to determine the most accurate prediction method.

---

## 🎯 Objectives
<ul>
  <li>Analyze customer data to identify churn patterns.</li>
  <li>Build predictive models like KNN, Decision Tree, Naive Bayes, and ANN.</li>
  <li>Compare model accuracies to find the best-performing algorithm.</li>
</ul>

---

## 🛠️ Data Preparation and Insights
<p>The dataset was cleaned and preprocessed to handle missing values, scale numerical features, and engineer new variables like:</p>
<ul>
  <li><code>TenureGroup</code>: Categorized tenure into ranges like "0-12 Months".</li>
  <li><code>EstimatedTotalCharges</code>: Derived by multiplying MonthlyCharges with tenure.</li>
</ul>
<p>Feature scaling was applied, and the data was split into training (70%) and testing (30%) subsets for model training and evaluation.</p>

---

## 📊 Models Used
<p>Four machine learning models were implemented:</p>
<ol>
  <li><b>K-Nearest Neighbors (KNN)</b>: A simple algorithm that classifies based on the closest data points.</li>
  <li><b>Decision Tree</b>: A tree-structured model that splits data based on decision rules.</li>
  <li><b>Naive Bayes</b>: A probabilistic model based on Bayes’ theorem.</li>
  <li><b>Artificial Neural Network (ANN)</b>: A complex model inspired by the human brain to identify non-linear patterns.</li>
</ol>

---

## 📈 Evaluation & Results
<p>The models were evaluated using accuracy as the metric. The results are as follows:</p>

| Model           | Accuracy |
|------------------|----------|
| KNN             | 85.23%   |
| Decision Tree   | 83.45%   |
| Naive Bayes     | 88.10%   |
| ANN             | 86.75%   |

<p>The Naive Bayes model performed the best, providing the highest accuracy for churn prediction.</p>

---

## 🔗 Future Improvements
<ul>
  <li>Integrate more advanced models like Random Forest or Gradient Boosting.</li>
  <li>Develop a real-time dashboard for predictions.</li>
  <li>Expand the analysis to include other datasets.</li>
</ul>

---

## 🚀 Usage
<p>To replicate this project, follow these steps:</p>
<ol>
  <li>Clone the repository: <code>git clone https://github.com/yourusername/churn-prediction.git</code></li>
  <li>Run the R scripts in an R environment (e.g., RStudio).</li>
  <li>Load your own dataset or use the sample dataset provided.</li>
</ol>

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/yourusername">Akash</a>
</p>
