function [net,res]=cnn_abp(net,l,res)

if (strcmp(net.layers{l}.function, 'sigm'))
    for j = 1 : numel(res.layers{l}.a)
        res.layers{l}.d{j} = res.layers{l}.a{j} .* (1 - res.layers{l}.a{j}).*res.layers{l + 1}.d{j};
    end
end


 if (strcmp(net.layers{l}.function, 'relu'))
     
      for j = 1 : numel(res.layers{l}.a)
          temp_aa=res.layers{l-1}.a{j};
          mask=max(sign(temp_aa), 0);
          res.layers{l}.d{j} =mask.*res.layers{l + 1}.d{j};
      end
 end

end

 