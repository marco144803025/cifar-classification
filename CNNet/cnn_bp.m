function [net,para]=cnn_bp(net,y,para)

[net,para]=cnn_obp(net, y,para);
n = numel(net.layers);
sa = size(para.layers{n-1}.a{1});
if (numel(sa)<3)
    sa(end+1)=1;
end

fvnum = sa(1) * sa(2);
    for j = 1 : numel(para.layers{n-1}.a)
        para.layers{n}.d{j} = reshape(para.fvd(((j - 1) * fvnum + 1) : j * fvnum, :), sa(1), sa(2), sa(3));
    end
    
for l = (n-1) : -1 : 1
   if strcmp(net.layers{l}.layer_type, 'c')  
        [net,para]=cnn_cbp(net,l,para);
    elseif strcmp(net.layers{l}.layer_type, 'p')
        [net,para]=cnn_pbp(net,l,para);
    elseif strcmp(net.layers{l}.layer_type, 'a')  
         [net,para]=cnn_abp(net,l,para);
    end

end

for l = 2 : n
        if strcmp(net.layers{l}.layer_type, 'c')
            for j = 1 : numel(para.layers{l}.a)
                for i = 1 : numel(para.layers{l - 1}.a)
                    temp=padarray(para.layers{l - 1}.a{i},[net.layers{l}.padding,net.layers{l}.padding]);
                   para.layers{l}.dk{i}{j} = convn(flipall(temp), para.layers{l+1}.d{j}, 'valid') / size(para.layers{l+1}.d{j}, 3);
%                      para.layers{l}.dk{i}{j} = convn(flipall(para.layers{l - 1}.a{i}), para.layers{l+1}.d{j}, 'valid') / size(para.layers{l+1}.d{j}, 3);
               end
                para.layers{l}.db{j} = sum(para.layers{l+1}.d{j}(:)) / size(para.layers{l+1}.d{j}, 3);
           end
        end
end
    

end