function net = set_weights(net, y)

    inputmaps = 1;
% %     n=numel(net.layers);
    for l = 1 : numel(net.layers)   %  layer
        if strcmp(net.layers{l}.layer_type, 'p')
            for j = 1 : inputmaps
                net.layers{l}.b{j} = 0;
            end
         elseif strcmp(net.layers{l}.layer_type, 'c')
            fan_out = net.layers{l}.outputmaps * net.layers{l}.kernelsize ^ 2;
            for j = 1 : net.layers{l}.outputmaps  %  output map
                fan_in = inputmaps * net.layers{l}.kernelsize ^ 2;
                for i = 1 : inputmaps  %  input map
                    net.layers{l}.k{i}{j} = (rand(net.layers{l}.kernelsize) - 0.5) * 2 * sqrt(6 / (fan_in + fan_out));
                end
                net.layers{l}.b{j} = 0;
            end
            inputmaps = net.layers{l}.outputmaps;  
        elseif strcmp(net.layers{l}.layer_type, 'f')
             fvnum = prod(net.layers{l-1}.mapsize) * inputmaps;
             onum = size(y, 1);
             net.ffb = zeros(onum, 1);
             net.ffW = (rand(onum, fvnum) - 0.5) * 2 * sqrt(6 / (onum + fvnum));
    
        end
    end
end

% 'onum' is the number of labels, that's why it is calculated using size(y, 1). If you have 20 labels so the output of the network will be 20 neurons.
% 'fvnum' is the number of output neurons at the last layer, the layer just before the output layer.
% 'ffb' is the biases of the output neurons.
% 'ffW' is the weights between the last layer and the output neurons. Note that the last layer is fully connected to the output layer, that's why the size of the weights is (onum * fvnum)