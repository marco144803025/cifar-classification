function [net , res]=cnn_obp(net,   batch_y,  res)

%% eluciden-distance loss

%  error
% % % batchsize=size(batch_y, 2);
% % % scores=res.o;
% % % s_scores=1./(1+exp(-scores));
% % % data_loss=0.5*sum(sum((s_scores-batch_y).^2))/batchsize;
% % % res.L=data_loss;
% % % dscores=(s_scores-batch_y).*s_scores.*(1-s_scores)/batchsize;
% % % res.fvd=net.ffW'*dscores;
% % % res.dffW=dscores*res.fv';
% % % res.dffb=mean(dscores,2);
% % % net.e = net.o - batch_y;
% % % %  loss function
% % % net.L = 1/2* sum(net.e(:) .^ 2) / size(net.e, 2);
% % % 
% % % net.od = net.e .* (net.o .* (1 - net.o));
% % % net.fvd = (net.ffW' * net.od);
% % % net.dffW = net.od * (net.fv)' / size(net.od, 2);
% % % net.dffb = mean(net.od, 2);

%% log of sigmoid loss
% % % batchsize=size(batch_y, 2);
% % % scores=res.o;
% % % delta=0.001;
% % % s_scores=1./(1+exp(-scores));
% % % data_loss=-sum( sum ( batch_y.*log(s_scores+delta)+(1-batch_y).*log(1-s_scores) ) ) /batchsize;
% % % dscores=(s_scores-batch_y)/batchsize;
% % % res.L=data_loss;
% % % res.fvd=net.ffW'*dscores;
% % % res.dffW=dscores*res.fv';
% % % res.dffb=mean(dscores,2);

%% softmax-loss 
[n_class, batchsize]=size(batch_y);
scores=res.o;
exp_scores=exp(scores);
dd=repmat(sum(exp_scores, 1), n_class, 1);
probs=exp_scores./dd;
correct_logprobs=-log(sum(probs.*batch_y, 1));
data_loss=sum(correct_logprobs)/batchsize;

res.L=data_loss;

dscores=probs-batch_y;
dscores=dscores/batchsize;

res.fvd=net.ffW'*dscores;
res.dffW=dscores*res.fv';
res.dffb=mean(dscores,2);


%% regularization loss
% % % reg_loss=0;
% % % for l=1:numel(net.layers)
% % %     if ~strcmp(net.layers{l}.type, 'c'), continue ; end
% % %     
% % % % %     ww=net.layers{l}.;
% % % % %     aa=ww.*ww;
% % % % %     reg_loss=reg_loss+0.5*opts.reg*sum(aa(:));
% % %     
% % % end

end


