---
layout: default
title: AI and Machine Learning
permalink: /data-science/
---

#  AI and Machine Learning Journal

A collection of code tutorials, project write-ups, and learning resources in machine learning, probabilistic modeling, and search algorithms.
<!--
## Learning

Begin here for theory notes, tutorials and lecture materials:  
* [Data Science Learning Resources →](/data-science/learning/)
-->
<br><br>

## Projects


1. **Unwanted Bias in Machine Learning Algorithms  **
**Purpose:** Assess gender bias in income-prediction models using the UCI Adult dataset.  
**Description:** I compared three classifiers—logistic regression, decision tree, and XGBoost—for predicting whether income exceeds \$50 000. After training each model, I applied the Cohort Shapley technique to quantify gender bias in both the dataset and the model predictions. While XGBoost achieved the highest accuracy (87.26 %), all models showed significant bias, correctly inferring gender from income at rates above 65 %. These results highlight the need for advanced bias mitigation methods in real-world applications.  
**Tools and Techniques:** Python (pandas, scikit-learn, XGBoost), Cohort Shapley, Jupyter Notebooks  

* [Full Report (PDF)](works/group_5_materials/group_5_report.pdf)  
* [Decision Tree Fairness Analysis (Notebook)](works/group_5_materials/Adult_fairness_DecisionTree.ipynb)  
* [Logistic Regression Fairness Analysis (Notebook)](works/group_5_materials/Adult_fairness_LogisticRegression.ipynb)  
* [XGBoost Fairness Analysis (Notebook)](works/group_5_materials/Adult_fairness_XGboost.ipynb)  
* [UCI Adult Dataset (TSV)](works/group_5_materials/adult.tsv)


<br><br>

2. **Twitter Spam Detection Model Comparison**  
**Purpose:** Classify tweets as spam or not spam.  
**Description:** Building on an initial SVM baseline for Twitter spam classification, I added at least eight new features (for example hashtag count, mention count, text length, sentiment score, URL presence and more) and implemented three additional algorithms: logistic regression, random forest and decision tree. I evaluated each model’s accuracy, precision and recall as I increased the feature set to compare overall performance and performance variation.  
   **Tools and Techniques:** Python (pandas, scikit-learn), feature-extraction script  
   * [Full Report (PDF)](/data-science/works/x_classification/hw1report%20(1).pdf)
   * [Model Implementation (Notebook)](../data-science/works/x_classification/hw1.ipynb)
   * [Feature Extraction (Python)](../data-science/works/x_classification/get_feature.py)
   * [Model Code(Python)](../data-science/works/x_classification/x_class.py)

<br><br>

3. **Burnt Pancake Solver**  
   **Description:** I solved the burnt pancake puzzle of sorting four pancakes by size and ensuring each burnt side faces down. I implemented a `flip(state, k)` routine in Python and applied breadth first search and A star search with a custom heuristic to find the optimal flip sequence.  
   **Tools and Techniques:** Python, BFS, A star  
   * [Project Report (PDF)](../data-science/works/Burnt_Pancake/Burnt_Pancake.pdf)
   * [Solver(Python)](../data-science/works/Burnt_Pancake/burnt_pancake.py)
     
<br><br>

4. **Q-Learning Pathfinding Agent**  
   **Description:** I built a Q learning agent on a 4×4 grid with goal, forbidden, and wall squares. Using an ε-greedy policy, the agent updates Q-values with a learning rate and discount factor to learn the optimal action in each square.  
   **Tools and Techniques:** Python, Q learning  
   * [Project Report (PDF)](../data-science/Q-learn/Qlearn.pdf)
   * [Solver(Python)](../data-science/Q-learn/qlearn.py)
     

