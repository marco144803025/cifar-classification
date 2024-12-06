

function [train_res, test_res]=Test_NN(handles)


dataname=handles.database_name;

current_data=handles.current_data;

opts.step_size=0.01;
opts.reg=2.5e-3;
opts.batchsize=handles.batch_size;
opts.numepochs=handles.train_epochs;
opts.hidden_layer=handles.hidden_layer;
opts.hidden_nodes=handles.hidden_nodes;
opts.class=10;
opts.classifier=handles.classifier;

train_sample=handles.trainsamples;
test_sample=handles.testsamples;

Out=handles.Train_out;

%% train the MINST database
if (strcmp(dataname, 'MNIST'))
    
    train_data=current_data.MINST.train_x;
    train_label=current_data.MINST.train_y;
    
    test_data=current_data.MINST.test_x;
    test_label=current_data.MINST.test_y;
    
    tra_data=double(train_data(1:train_sample, :))/255;
    train_y=double(train_label(1:train_sample, :));
    
    tes_data=double(test_data(1:test_sample, :))/255;
    test_y=test_label(1:test_sample, :);
    
    [predict_label, target_label]=Get_Results(tra_data, train_y, opts, Out);
    train_res=Get_performance(predict_label, target_label, opts);
    [predict_label, target_label]=Get_Results(tes_data, test_y, opts, Out);
    test_res=Get_performance(predict_label, target_label, opts);
          
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
    test_y=test_label(1:test_sample, :);
    
    tra_data_2=(tra_data(1:train_sample, 1:1024)+tra_data(1:train_sample, 1025:2048)+tra_data(1:train_sample, 2049:3072))/3;
    tes_data_2=(tes_data(1:test_sample, 1:1024)+tes_data(1:test_sample, 1025:2048)+tes_data(1:test_sample, 2049:3072))/3;
    
    [predict_label, target_label]=Get_Results(tra_data_2, train_y, opts, Out);
    train_res=Get_performance(predict_label, target_label, opts);
    [predict_label, target_label]=Get_Results(tes_data_2, test_y, opts, Out);
    test_res=Get_performance(predict_label, target_label, opts);

    
end

 sprintf('test already done..')










