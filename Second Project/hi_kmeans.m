function [node] = hi_kmeans(data,b,depth)
    data=data;
    [node]=recur_tree(data,b,depth);
        function [nod] = recur_tree(datanode,brunch,level_count)  
            if(size(datanode,2)<brunch)
                brunch=size(datanode,2);
            end
            ret_descriptors={};
            ret_centroids=[];
            ret_data_node=[];
            weight=zeros(1,50);
            ret_tree={};
            building_node =[];
            if level_count>3
                fprintf("%d ",level_count);
            end
            [descriptors_nodes,C] = kmeans(datanode(1:128,:)',brunch,'MaxIter',10000);
            ret_centroids=[C];
            ret_descriptors=[descriptors_nodes];
            ret_data_node=[datanode(:,:)];
            [Ce,ia,ic] = unique(ret_data_node(129,:));
            a_counts = accumarray(ic,1);
            feature_per_building_node = [Ce', a_counts];
            different_buiding_node = size(Ce,2);
            for i=1:50
                feature_i=find(feature_per_building_node(:,1)==i);
                if isempty(feature_i)
                    f_ij=0;
                else
                    f_ij=feature_per_building_node(feature_i,2);
                end
                primo=(f_ij/size(ic,1));
                secondo=log2(50/different_buiding_node);
                weight(1,i)=primo*secondo;
            end
            if level_count == 1
                ret_tree=NaN;
                nod={ret_descriptors,ret_centroids,ret_data_node,different_buiding_node,feature_per_building_node,weight,ret_tree}; 
                return;
            end
            for i = 1:brunch
                ret_tree=[ret_tree,[recur_tree(datanode(:,descriptors_nodes==i),brunch,level_count-1)]];

            end
            nod={ret_descriptors,ret_centroids,ret_data_node,different_buiding_node,feature_per_building_node,weight,ret_tree}; 
        end

end

