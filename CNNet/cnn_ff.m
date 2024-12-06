function [net,res]=cnn_ff(net,train_x,res)

 n = numel(net.layers);
 res.layers{1}.a{1} = train_x;
 m=size(train_x);
 m=m(3);
 
 for l = 2 : n
     
     if strcmp(net.layers{l}.layer_type, 'c')
         [net,res]=cnn_cff(net,l,m,res);
     elseif strcmp(net.layers{l}.layer_type, 'p')
         [net,res]=cnn_pff(net,l,res);
     elseif strcmp(net.layers{l}.layer_type, 'a')
         [net,res]=cnn_aff(net,l,res);
     elseif strcmp(net.layers{l}.layer_type, 'f')
         [net,res]=cnn_fff(net,l,res);
     end
     
 end
 
end


 