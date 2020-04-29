%This code will run a simple example, showing how our graph-Laplacian based semi-supervised clustering works on circles discs.

clear all
close all
nsamples = [200,400,600];       %number of samples in each class
radial_centers = [0, 1.5, 3];   %Each classes radial center
decay_length = [0.3, 0.3, 0.3]; %The decay length of each class (how far the points in a single class will scatter)
label_certainty = 10;           %Determines how certain we are of each observed label, higher is more certain. 
nlabels_pr_class = 4;           %selects the number of initial labels present in each class
nn = 29;                        %Number of nearest neighbours 
alpha = 100;                    %hyper parameter that determines the relative strength between the two terms. Suggested values are in the region (1 - 1000)
beta = 1e-3;                    %hyper parameter that stabilizes the often ill-conditioned matrix we need to cluster. Suggested values are in the region (1e-2 - 1e-8)


%%
%Generate dataset
[X,labels_true] = generate_gaussian_circles(nsamples,radial_centers,decay_length);

%Randomly select starting labels
[labels,idx_selected] = select_starting_labels(labels_true,nlabels_pr_class);
nc = length(nsamples);
n = length(labels);

%Create the observed label pseudo-probabilities
Yobs = convert_labels_to_pseudo_probabilities(labels,nc,label_certainty);
Ytrue = convert_labels_to_pseudo_probabilities(labels_true,nc,label_certainty);

%Shows the data
figure(1)
subplot(1,2,1)
scatter(X(:,1),X(:,2),200,convert_pseudo_probability_to_probability(Yobs),'.')
title('Input data')
subplot(1,2,2)
scatter(X(:,1),X(:,2),200,convert_pseudo_probability_to_probability(Ytrue),'.')
title('True labels')

%Create the associated diagonal weight matrix
w = zeros(n,1);
w(idx_selected) = 1;
W = spdiags(w,0,n,n);

%Generates the graph-laplacian
[A,dd] = getAdjacencyMatrix(X,nn);
epsilon = median(dd(:));
[L,~,~] = getGraphLaplacian(X,A,epsilon);

%Clusters the data
Y = SSL_clustering(L,alpha,beta,Yobs,W);

%Plots the result
figure(2)
subplot(1,2,1)
scatter(X(:,1),X(:,2),200,convert_pseudo_probability_to_probability(Y),'.')
title('Label probabilities')
subplot(1,2,2)
[~,label_pred] = max(Y,[],2);
U_pred_boost = convert_pseudo_probability_to_probability(convert_labels_to_pseudo_probabilities(label_pred,nc,label_certainty));
scatter(X(:,1),X(:,2),200,U_pred_boost,'.')
title('Labels predicted')
