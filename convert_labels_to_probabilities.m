function Y = convert_labels_to_pseudo_probabilities(labels,nc)
n = length(labels);
Y = zeros(n,nc);
idxs = find(labels ~= -1);
for i=1:length(idxs)
    idx = idxs(i);
    Y(idx,labels(idx)) = 1;
end
Y= Y- mean(Y,2);

end