function [predict_label, target_label] = cnn_test(net, x, y, res)
    %  feedforward
    [net, res] = cnn_ff(net, x, res);
% %     max_pre=res.o;
    [~, predict_label] = max(res.o);
    [~, target_label] = max(y);
% %     right_ind = find(predict == target);
% %     
% %     test_res=res;
% % 
% %      acc= numel(right_ind) / size(y, 2);
end
