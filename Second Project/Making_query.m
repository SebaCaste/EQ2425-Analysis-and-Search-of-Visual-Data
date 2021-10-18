accurancy=0;
percentage=70;
for j=1:50
    result=query_node(j,query_descriptors,first_node,brunches,percentage);
    if result==j
        accurancy=accurancy+1;
    end
end
fprintf("accurancy %d",accurancy/50);


%TOP5

accurancy_Top5=0;
for j=1:50
    results=query_node_top5(j,query_descriptors,first_node,brunches,percentage);
    if any(results(:) == j)
        accurancy_Top5=accurancy_Top5+1;
    end
end
fprintf("accurancy TOP 5 %d",accurancy_Top5/50);
