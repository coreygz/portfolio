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

1. **Burnt Pancake Solver**  
   **Description:** I solved the burnt pancake puzzle of sorting four pancakes by size and ensuring each burnt side faces down. I implemented a `flip(state, k)` routine in Python and applied breadth first search and A star search with a custom heuristic to find the optimal flip sequence.  
   **Tools and Techniques:** Python, BFS, A star  
   * [Project Report (PDF)](../data-science/works/Burnt_Pancake/Burnt_Pancake.pdf)
   * [Solver(Python)](../data-science/works/Burnt_Pancake/burnt_pancake.py)
     
<br><br>

2. **Q Learning Pathfinding Agent**  
   **Description:** I built a Q learning agent on a 4×4 grid with goal, forbidden, and wall squares. Using an ε-greedy policy, the agent updates Q-values with a learning rate and discount factor to learn the optimal action in each square.  
   **Tools and Techniques:** Python, Q learning  
   * [Project Report (PDF)](../data-science/Q-learn/Qlearn.pdf)
   * [Solver(Python)](../data-science/Q-learn/qlearn.py)
     
<br><br>

3. **Tweet Classification Model Comparison**  
   **Description:** I compared four **machine learning** classifiers—SVM, Logistic Regression, Random Forest, and Decision Tree—on Twitter data using three feature sets (full, reduced, and expanded). I balanced the dataset with SMOTE, then evaluated each model’s accuracy, precision, and recall to determine the best approach.  
   **Tools and Techniques:** Python (pandas, scikit-learn), SMOTE, feature-extraction script  
   * [Full Report (PDF)](.../data-science/works/x_classification/hw1report%20(1).pdf)
   * [Model Implementation (Notebook)](.../data-science/works/x_classification/hw1.ipynb)
   * [Feature Extraction (Python)](.../data-science/works/x_classification/get_feature.py)
   * [Model Code(Python)](.../data-science/works/x_classification/x_class.py)
