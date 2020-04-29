function Y = convert_labels_to_pseudo_probabilities(labels,nc,label_certainty)
%Converts a vector of labels into a matrix of pseudo probabilities centered
%around zero. The label_certainty determines how large a value/how certain
%each labelled datapoint will be.
n = length(labels);
Y = zeros(n,nc);
idxs = find(labels ~= -1);
for i=1:length(idxs)
    idx = idxs(i);
    Y(idx,labels(idx)) = label_certainty;
end
Y= Y- mean(Y,2);

end