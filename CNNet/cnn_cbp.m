function [net,para]=cnn_cbp(net,l,para)

if(l>1)

for i = 1 : numel(para.layers{l-1}.a)
        
        z = zeros(size(para.layers{l-1}.a{1})+2*[net.layers{l}.padding,net.layers{l}.padding,0]);
                for j = 1 : numel(para.layers{l}.a)
                     z = z + convn(para.layers{l+1}.d{j}, rot180(net.layers{l}.k{i}{j}), 'full');
                end
                
                for k=1:net.layers{l}.padding
                m=size(z);   
                z(1,:,:)=[];
                z(:,1,:)=[];
                z(m(1)-1,:,:)=[];
                z(:,m(1)-1,:)=[];
                end

                para.layers{l}.d{i} = z;
end
else
end
function X = rot180(X)
        X = flipdim(flipdim(X, 1), 2);
    end
end
