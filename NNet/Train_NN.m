

function Out=Train_NN(handles)


dataname=handles.database_name;

current_data=handles.current_data;

opts.step_size=handles.learningrate;
opts.reg=handles.regularization;
opts.batchsize=handles.batch_size;
opts.numepochs=handles.train_epochs;
opts.hidden_layer=handles.hidden_layer;
opts.hidden_nodes=handles.hidden_nodes;
opts.class=10;
opts.classifier=handles.classifier;

train_sample=handles.trainsamples;


fprintf('Check the parameters: \n ');
fprintf('Database: %s \n', dataname);
fprintf('Classifier: %s \n',  opts.classifier);
fprintf('Learning rate:  %.2f  \n',  opts.step_size);
fprintf('Regularization: %.4f \n', opts.reg);
fprintf('Train samples: %d \n', train_sample);
fprintf('Batch size: %d \n', opts.batchsize);
fprintf('Train epochs: %d \n ', opts.numepochs);
fprintf('Hidden layer: %d \n', opts.hidden_layer);
if (opts.hidden_layer)
    fprintf('Hidden nodes: %d \n', opts.hidden_nodes);
end

fprintf('Please press the Enter key to continue............ \n');
a=input('');


%% train the MINST database
if (strcmp(dataname, 'MNIST'))
    
    train_data=current_data.MINST.train_x;
    train_label=current_data.MINST.train_y;
    
    tra_data=double(train_data(1:train_sample, :))/255;
    train_y=double(train_label(1:train_sample, :));
    
% %     tes_data=double(test_data(1:test_sample, :))/255;
% %     test_y=test_label(1:test_sample, :);
    
   sprintf('training...... please wait')

    if (strcmp(opts.classifier, 'MLP'))
        
        if(opts.hidden_layer==0)
            Out=MLP_Classifier(tra_data,  train_y,  opts);
        else
           Out=MLP_Classifier_1(tra_data, train_y, opts); 
        end
    end
    
    if (strcmp(opts.classifier, 'Softmax'))
        if(opts.hidden_layer==0)
            Out=Softmax_Classifier(tra_data,  train_y,  opts);
        else
            Out=Softmax_Classifier_1(tra_data, train_y, opts);
        end
    end
     
    sprintf('train already done..')
    
end

%% train the CIFAR10 database
if (strcmp(dataname, 'CIFAR10'))
    
    train_data=current_data.CIFAR10.train_x;
    train_label=current_data.CIFAR10.train_y;
    
    tra_data=double(train_data(1:train_sample, :))/255;
    train_y=double(train_label(1:train_sample, :));
    
    tra_data_2=(tra_data(1:train_sample, 1:1024)+tra_data(1:train_sample, 1025:2048)+tra_data(1:train_sample, 2049:3072))/3;
    
     sprintf('training...... please wait')

    if (strcmp(opts.classifier, 'MLP'))
        
        if(opts.hidden_layer==0)
            Out=MLP_Classifier(tra_data_2,  train_y,  opts);
        else
           Out=MLP_Classifier_1(tra_data_2, train_y, opts); 
        end
    end
    
    if (strcmp(opts.classifier, 'Softmax'))
        if(opts.hidden_layer==0)
            Out=Softmax_Classifier(tra_data_2,  train_y,  opts);
        else
            Out=Softmax_Classifier_1(tra_data_2, train_y, opts);
        end
    end
     sprintf('train already done..')
     
end

