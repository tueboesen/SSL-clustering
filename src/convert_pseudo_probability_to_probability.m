function U = convert_pseudo_probability_to_probability(Y)
%A simple normalization routine, in this case softmax has been chosen.
U = exp(Y)./sum(exp(Y),2);
end