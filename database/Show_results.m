


function Show_results(handles)

train_loss=handles.Train_loss;

train_res=handles.train_res;
test_res=handles.test_res;

plot_result=handles.plot_results;

switch plot_result;
    case 'Train error'  % 
        plot(train_loss);
        xlabel('Epoch');
        ylabel('Training error');
       
        
    case 'Train acc' % 
        stem(train_res.acc);
        ylim([0 1.0]);
        text(1.1, train_res.acc, num2str(train_res.acc));
        ylabel('Train Acc.');
        
    case 'Test acc' % 
        stem(test_res.acc);
        ylim([0 1.0]);
        text(1.1, test_res.acc, num2str(test_res.acc));
        ylabel('Test Acc.');
        
     case 'Train Confusion matrix' % 
        imtool(train_res.Con_mat);
        
     case 'Test Confusion matrix' % 
        imtool(test_res.Con_mat);
        
end


