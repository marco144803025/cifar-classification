function [net,res]=cnn_pbp(net, l, res)

%% avg pooling

if (strcmp(net.layers{l}.type, 'avg' ))

    for j = 1 : numel(res.layers{l}.a)
        res.layers{l}.d{j} =  expand(res.layers{l + 1}.d{j}, [net.layers{l}.scale net.layers{l}.scale 1]) / net.layers{l}.scale ^ 2;
    end
    
end


 %% max pooling
 if (strcmp(net.layers{l}.type, 'max' ))
     
     for j = 1 : numel(res.layers{l}.a)
         res.layers{l}.d{j} =  expand(res.layers{l + 1}.d{j}, [net.layers{l}.scale net.layers{l}.scale 1]) .*  res.layers{l}.idx{j};
     end
 
 end
 
end
