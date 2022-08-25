# AcceleratedClan-BasedCulturalAlgorithm-FS
ABSTRACT:
A new novel-multi population Accelerated Clan-based Cultural Algorithm is proposed (ACCA) for feature selection of biomedical data. Feature Selection involves the selection of relevant subset features from a large dataset to improve its quality and build efficient learning models. This process often requires an exhaustive search of the feature space especially when the search is large. The Clan-based  Cultural Algorithm (CCA) model is a good approach to feature selection due its global search capabilities and it uses its knowledge to guide the search process. It consists of tiered belief spaces to overcome premature convergence however, it suffers from time complexities.The ACCA model proposed is an improvement of the Clan-based Cultural Algorithm (CCA) model and it focuses on improving the execution time  by use of vectorization. Vectorization refers to the process of revising loop - based, scalar oriented code, to use matrix and vector operations.The proposed algorithm was tested on seven benchmark machine learning datasets obtained from Kaggle and the UCI machine learning respiratory and its speed and  performance compared against common feature selection models such as;  Clan- based Cultural Algorithm (CCA), Genetic Algorithm (GA), Artificial Bee Colony (ABC), Particle Swarm Optimization (PSO), Bee Algorithm (BA), and Ant Colony Optimization (ACO). The experimental results showed that ACCA achieved the lowest elapsed timing across all the datasets.

The steps for running the code:

1. Open the preprocess_data.m file and prepre it for the dataset you wish to use. Note: the target values need to be in numerical format.

2. Run the main.m file. 

3. Please note the CCA uses the KNN classifier (defined in the knn.m script). If you wish you can modify the classifier to any classifier of your choice.
