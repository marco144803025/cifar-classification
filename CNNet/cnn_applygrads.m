function [net,res] = cnn_applygrads(net, opts,res)

% %   tt=min(floor(epoch/10)+1, 5);

    for l = 2 : numel(net.layers)
        if strcmp(net.layers{l}.layer_type, 'c')
            for j = 1 : numel(res.layers{l}.a)
                for ii = 1 : numel(res.layers{l - 1}.a)
                    net.layers{l}.k{ii}{j} = net.layers{l}.k{ii}{j} - opts.alpha * res.layers{l}.dk{ii}{j};
                end
                net.layers{l}.b{j} = net.layers{l}.b{j} - opts.alpha * res.layers{l}.db{j};
            end
        end
    end

    net.ffW = net.ffW - opts.alpha * res.dffW;
    net.ffb = net.ffb - opts.alpha * res.dffb;
end
