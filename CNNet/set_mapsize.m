function net=set_mapsize(net,  train_x)

mapsize = size(squeeze(train_x(:, :, 1)));
  for l = 2 : numel(net.layers)   %  layer
        if strcmp(net.layers{l}.layer_type, 'p')
            net.layers{l}.mapsize = net.layers{l-1}.mapsize / net.layers{l}.scale;
            assert(all(floor(net.layers{l}.mapsize)==net.layers{l}.mapsize), ['Layer ' num2str(l) ' size must be integer. Actual: ' num2str(net.layers{l}.mapsize)]);
        elseif strcmp(net.layers{l}.layer_type, 'c')
            if (l==2)
            net.layers{l}.mapsize = (mapsize - net.layers{l}.kernelsize+2*net.layers{l}.padding)/net.layers{l}.stride+1 ;
            else 
            net.layers{l}.mapsize = (net.layers{l-1}.mapsize - net.layers{l}.kernelsize+2*net.layers{l}.padding)/net.layers{l}.stride + 1;
            end
            assert(all(floor(net.layers{l}.mapsize)==net.layers{l}.mapsize), ['Layer ' num2str(l) ' size must be integer. Actual: ' num2str(net.layers{l}.mapsize)]);  
        elseif strcmp(net.layers{l}.layer_type, 'a')
           net.layers{l}.mapsize = net.layers{l-1}.mapsize;
        else
        end       
  end
end
