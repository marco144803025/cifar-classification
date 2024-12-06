function [net,para]=cnn_cff(net,l,m,para)
  net.layers{2}.inputmaps = 1;
  for j = 1 : net.layers{l}.outputmaps 
    z = zeros([net.layers{l}.mapsize,m]);
    for i=1 : net.layers{l}.inputmaps
       temp=padarray(para.layers{l - 1}.a{i},[net.layers{l}.padding,net.layers{l}.padding]);
        z = z + convn(temp, net.layers{l}.k{i}{j}, 'valid');
%          z = z + convn(para.layers{l - 1}.a{i}, net.layers{l}.k{i}{j}, 'valid');
    end
  para.layers{l}.a{j} = z + net.layers{l}.b{j};
  end
  net.layers{l+1}.inputmaps = net.layers{l}.outputmaps;
end
