

function [net, res]=Train_CNN(handles)


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

train_sample=handles.trainsamples;


fprintf('Check the parameters: \n ');
fprintf('Database: %s \n', dataname);
fprintf('Learning rate:  %.2f  \n',  opts.alpha);
fprintf('Train samples: %d \n', train_sample);
fprintf('Batch size: %d \n', opts.batchsize);
fprintf('Train epochs: %d \n ', opts.numepochs);

fprintf('Please press the Enter key to continue............ \n');
a=input('');


%% train the MINST database
if (strcmp(dataname, 'MNIST'))
    
    train_data=current_data.MINST.train_x;
    train_label=current_data.MINST.train_y;
    
    tra_data=double(train_data(1:train_sample, :))/255;
    train_y=double(train_label(1:train_sample, :));
    
    xx=reshape(tra_data', [28 28 train_sample]);
    yy=train_y';

end

%% train the CIFAR10 database
if (strcmp(dataname, 'CIFAR10'))
    
    train_data=current_data.CIFAR10.train_x;
    train_label=current_data.CIFAR10.train_y;
    
    tra_data=double(train_data(1:train_sample, :))/255;
    train_y=double(train_label(1:train_sample, :));
    
    tra_data_2=(tra_data(1:train_sample, 1:1024)+tra_data(1:train_sample, 1025:2048)+tra_data(1:train_sample, 2049:3072))/3;
    
    xx=reshape(tra_data_2', [32 32 train_sample]);
    yy=train_y';
      
end

 sprintf('training...... please wait')

 [net, res]=cnn_build(opts);
 net=set_mapsize(net,  xx);
 net = set_weights(net, yy);
 [net,res] = cnn_train(net, xx, yy, opts, res);
     
  sprintf('train already done..')

