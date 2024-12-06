function [net, res]=cnn_fff(net, l, res)
 %  concatenate all end layer feature maps into vector
    res.fv = [];
    for j = 1 : numel(res.layers{l-1}.a)
        sa = size(res.layers{l-1}.a{j});
        if (numel(sa)<3)
            sa(end+1)=1;
        end
            res.fv = [res.fv; reshape(res.layers{l-1}.a{j}, sa(1) * sa(2),  sa(3))];
    end
    
    %  feedforward into output perceptrons
% %     net.o = sigm(net.ffW * net.fv + repmat(net.ffb, 1, size(net.fv, 2)));
    
    res.o=net.ffW * res.fv + repmat(net.ffb, 1, size(res.fv, 2));
