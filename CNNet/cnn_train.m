function [net,res] = cnn_train(net, x, y, opts, res)
    m = size(x, 3);
    numbatches = floor(m / opts.batchsize);
    if rem(numbatches, 1) ~= 0
        error('numbatches not integer');
    end

    res.loss = [];
    for epoch = 1 : opts.numepochs
        disp(['epoch ' num2str(epoch) '/' num2str(opts.numepochs)]);
        tic;
        kk = randperm(m);
        loss=0;
        for l = 1 : numbatches
            
            batch_x = x(:, :, kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));
            batch_y = y(:,    kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));

            [net, res] = cnn_ff(net, batch_x,  res);
            [net, res] = cnn_bp(net, batch_y,  res);
            [net, res] = cnn_applygrads(net, opts,  res);

            loss=loss+res.L;
        end
        toc;
        
        if isempty(res.loss)
            res.loss(1) = loss/numbatches;
        else
            res.loss(end + 1) = 0.0 * res.loss(end) + 1 * loss/numbatches;
        end
        
        sprintf('train loss is %f', res.loss(end))
    
    end
    
   
    
end







