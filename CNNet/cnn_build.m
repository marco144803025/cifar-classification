function [net, res]=cnn_build(opts)
net.layers = {
    
    struct('layer_type', 'i') %input layer
    
    %% con-relu-pooling
    struct('layer_type',  'c',   'outputmaps', opts.Conv1, 'kernelsize', 5,  'padding', 0,  'stride', 1) %convolution layer
    struct('layer_type',  'a',    'function', 'relu')           %activation layer  'relu' or 'sigm'
    struct('layer_type',  'p',    'scale', 2, 'type', opts.Pool1)    %pooling layer 'Max' or 'Avg'
    
    %% con-relu-pooling
    struct('layer_type',  'c',   'outputmaps', opts.Conv2,  'kernelsize', 5,  'padding', 0,  'stride', 1) %convolution layer
    struct('layer_type',  'a',   'function', 'relu')                    %activation layer  'relu' or 'sigm'
    struct('layer_type',  'p',  'scale', 2,  'type', opts.Pool2)             %pooling layer, 'Max' or 'Avg'
    
    %% full-connected
    struct('layer_type', 'f')    %full-connected layer
    
};
% % % 
% % % 
res=[ ];


