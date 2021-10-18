one_feature_query=query_feature(first_node,database_descriptors(1:128,1)',brunches)
function result = query_feature(current_node,feature,n_center)
    feature=double(feature);
    n_data_node=7;
    dist=norm(feature - current_node{1, 2}(1,:));
    centrum=1;
    for i = 2:n_center
        temp_dist=norm(feature - current_node{1, 2}(i,:));
        if temp_dist<dist
            dist=temp_dist;
            centrum=i;
        end
    end
    if ~isequaln(current_node{1, n_data_node},NaN)
        current_node=current_node{1, n_data_node,1}(1,1+(n_data_node*(centrum-1)):n_data_node+(n_data_node*(centrum-1)));
        next_node_result=query_feature(current_node,feature,n_center);
        result=[centrum;next_node_result];
    else
        result=centrum;
    end
end