

function [train_res, test_res]=Test_CNN(handles)


dataname=handles.database_name;

current_data=handles.current_data;
opts.alpha=handles.learningrate;
opts.batchsize=handles.batch_size;
opts.numepochs=handles.train_epochs;
opts.class=10;
opts.Conv1=handles.Conv1;
opts.Conv2=handles.Conv2;
opts.Pool1=handles.Pool1;
opts.Pool2=handles.Pool2;
opts.batchsize=handles.batch_size;
opts.numepochs=handles.train_epochs;
opts.class=10;

train_sample=handles.trainsamples;
test_sample=handles.testsamples;

net=handles.net;
res=handles.res;

%% train the MINST database
if (strcmp(dataname, 'MNIST'))
    
    train_data=current_data.MINST.train_x;
    train_label=current_data.MINST.train_y;
    
    test_data=current_data.MINST.test_x;
    test_label=current_data.MINST.test_y;
    
    tra_data=double(train_data(1:train_sample, :))/255;
    train_y=double(train_label(1:train_sample, :));
    
    tes_data=double(test_data(1:test_sample, :))/255;
    test_y=double(test_label(1:test_sample, :));
    
    train_xx=reshape(tra_data', [28 28 train_sample]);
    train_yy=train_y';
    
    test_xx=reshape(tes_data', [28 28 test_sample]);
    test_yy=test_y';
    
    [train_predict, train_target] = cnn_test(net, train_xx, train_yy, res);
    train_res=Get_performance(train_predict, train_target, opts);
    [test_predict, test_target] = cnn_test(net, test_xx, test_yy, res);
    test_res=Get_performance(test_predict, test_target, opts);
    
end

%% train the CIFAR10 database
if (strcmp(dataname, 'CIFAR10'))
    
    train_data=current_data.CIFAR10.train_x;
    train_label=current_data.CIFAR10.train_y;
    test_data=current_data.CIFAR10.test_x;
    test_label=current_data.CIFAR10.test_y;
    
    tra_data=double(train_data(1:train_sample, :))/255;
    train_y=double(train_label(1:train_sample, :));
    
    tes_data=double(test_data(1:test_sample, :))/255;
    test_y=double(test_label(1:test_sample, :));
    
    tra_data_2=(tra_data(1:train_sample, 1:1024)+tra_data(1:train_sample, 1025:2048)+tra_data(1:train_sample, 2049:3072))/3;
    tes_data_2=(tes_data(1:test_sample, 1:1024)+tes_data(1:test_sample, 1025:2048)+tes_data(1:test_sample, 2049:3072))/3;
    
    train_xx=reshape(tra_data_2', [32 32 train_sample]);
    train_yy=train_y';
    
    test_xx=reshape(tes_data_2', [32 32 test_sample]);
    test_yy=test_y';
    
    [train_predict, train_target] = cnn_test(net, train_xx, train_yy, res);
    train_res=Get_performance(train_predict, train_target, opts);
    [test_predict, test_target] = cnn_test(net, test_xx, test_yy, res);
    test_res=Get_performance(test_predict, test_target, opts);

    
end

 sprintf('test already done..')










