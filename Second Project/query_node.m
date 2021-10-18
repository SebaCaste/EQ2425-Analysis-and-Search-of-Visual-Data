function final_score = query_node(number_image_query,query_descriptors,first_node,brunches,percentage)
    score=zeros(1,50);
    list_descriptor= query_descriptors(1:128,find(query_descriptors(129,:)==number_image_query));
    siz=size(list_descriptor,2);
    list_descriptor=list_descriptor(1:128,1:floor((siz/100)*percentage));
    for i=1:size(list_descriptor(1:128,:),2)
        one_feature_query=query_feature_last_node(first_node,list_descriptor(1:128,i)',brunches);
        score=score+one_feature_query{1,6};
    end
    [M,I] = max(score);
    final_score=I;
    function last_node = query_feature_last_node(current_node,feature,n_center)
        feature=double(feature);
        n_data_node=7;
        dist=norm(feature - current_node{1, 2}(1,:));
        centrum=1;
        for zi = 2:size(current_node{1, 2},1)
            temp_dist=norm(feature - current_node{1, 2}(zi,:));
            if temp_dist<dist
                dist=temp_dist;
                centrum=zi;
            end
        end
        if ~isequaln(current_node{1, n_data_node},NaN)
            current_node=current_node{1, n_data_node,1}(1,1+(n_data_node*(centrum-1)):n_data_node+(n_data_node*(centrum-1)));
            next_node_result=query_feature_last_node(current_node,feature,n_center);
            last_node=next_node_result;
        else
            last_node=current_node;
        end
    end
end