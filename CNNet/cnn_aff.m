function [net,res]=cnn_aff(net,l,res)

%% sigmoid function
if (strcmp(net.layers{l}.function, 'sigm'))
for j=1:net.layers{l}.inputmaps
     res.layers{l}.a{j} = sigm(res.layers{l-1}.a{j});
end
% %  net.layers{l+1}.inputmaps = net.layers{l}.inputmaps;
end


%% relu function
if (strcmp(net.layers{l}.function, 'relu'))
    for j=1:net.layers{l}.inputmaps
     res.layers{l}.a{j} = max(res.layers{l-1}.a{j},0);
    end
end


 net.layers{l+1}.inputmaps = net.layers{l}.inputmaps;
 
 
end


