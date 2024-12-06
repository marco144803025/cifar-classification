
%% compute the acc and confusiion matrix


function [predict_label, target_label]=Get_Results(data_x, data_y, opts, Out)

n_sample=size(data_x, 1);

if (strcmp(opts.classifier, 'MLP'))
    
    if(opts.hidden_layer==0)
        
        cc=repmat(Out.b, n_sample, 1);
        scores=data_x*Out.W+cc;
        
    else
        
        cc=repmat(Out.b1, n_sample, 1);
        dd=data_x*Out.W1+cc;
        hidden_val=1./(1+exp(-dd));
        scores=hidden_val*Out.W2+repmat(Out.b2, n_sample, 1);
        
    end
    
end


if (strcmp(opts.classifier, 'Softmax'))
    
    if(opts.hidden_layer==0)
        
        cc=repmat(Out.b, n_sample, 1);
        scores=data_x*Out.W+cc;
        
    else
        
        cc=repmat(Out.b1, n_sample, 1);
        dd=data_x*Out.W1+cc;
        hidden_val=max(0, dd);
        scores=hidden_val*Out.W2+repmat(Out.b2, n_sample, 1);
     
    end
   
end

        [~, predict_label]=max(scores, [ ], 2);
        [~, target_label]=max(data_y, [ ], 2);
end