function [labels,idx_selected] = select_starting_labels(labels_true,ns)
%randomly selects ns labels from each class and labels those according to
%labels_true, all other labels are assigned the value -1
labels = - ones(length(labels_true),1);
labels_unique = unique(labels_true);
idx_selected = [];
for i=1:length(labels_unique)
   label = labels_unique(i);
   idxs = find(labels_true == label);
   idxs = idxs(randperm(length(idxs)));
   idx_selected = [idx_selected; idxs(1:ns)];
end
labels(idx_selected) = labels_true(idx_selected);
end