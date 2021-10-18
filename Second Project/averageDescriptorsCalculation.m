num_descriptor=[];
num_descriptor_query=[];
average_descriptor=0;
average_descriptor_query=0;

for i=1:50
    n=size(query_descriptors(1:128,find(query_descriptors(129,:)==i)));
    num_descriptor_query=[num_descriptor_query, n(2)];
    average_descriptor_query=average_descriptor_query+n(2);
end
for i=1:50
    n=size(database_descriptors(1:128,find(database_descriptors(129,:)==i)));
    num_descriptor=[num_descriptor, n(2)];
    average_descriptor=average_descriptor+n(2);
end
average_descriptor_query=average_descriptor_query/50;
average_descriptor=average_descriptor/149;
% h1 = bar(1:50,num_descriptor)
h2 = bar(num_descriptor)
xlabel('building number')
ylabel('descriptors')
title('Number of descriptors for building query')

