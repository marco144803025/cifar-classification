function [net,  res]=cnn_pff(net, l, res)


%% average pooling

if (strcmp(net.layers{l}.type, 'avg' ))

    for j = 1 : net.layers{l}.inputmaps
        z = convn(res.layers{l - 1}.a{j}, ones(net.layers{l}.scale) / (net.layers{l}.scale ^ 2), 'valid');   
        res.layers{l}.a{j} = z(1 : net.layers{l}.scale : end, 1 : net.layers{l}.scale : end, :);
    end
    net.layers{l+1}.inputmaps = net.layers{l}.inputmaps;

end

%% max-pooling

if (strcmp(net.layers{l}.type, 'max' ))

    for j = 1 : net.layers{l}.inputmaps
        
        in=double(res.layers{l - 1}.a{j});
        sa=size(in);
        outmap = zeros(size(in));
        [out, outidx] = MaxPooling(in,  [2  2]);
        aa=outmap(:);
        aa(outidx) = 1;
        outmap = reshape(aa, [sa(1)  sa(2)  sa(3)]);
        res.layers{l}.a{j} = out;
        res.layers{l}.idx{j}=outmap;
        
    end
    
    net.layers{l+1}.inputmaps = net.layers{l}.inputmaps;
 
end

end



