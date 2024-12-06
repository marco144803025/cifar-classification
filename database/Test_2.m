

load MINST;

addpath('CNNet\');
addpath('CNNet\util');

opts.step_size=0.1;
opts.reg=0.002;
opts.batchsize=200;
opts.numepochs=10;
opts.class=10;
opts.classifier='MLP';
opts.alpha=2.5;

train_data=MINST.train_x;
train_label=MINST.train_y;

train_sample=1000;

tra_data=double(train_data(1:train_sample, :))/255;
train_y=double(train_label(1:train_sample, :));

xx=reshape(tra_data, [28 28 1000]);
yy=train_y';

[net, res]=cnn_build();
net=set_mapsize(net,  xx);
net = set_weights(net, yy);
[net,res] = cnn_train(net, xx, yy, opts, res);


% % Out=MLP_Classifier_1(tra_data, train_y, opts);
% % Out=Softmax_Classifier_1(tra_data, train_y, opts);
% %  train_res=Get_Results(tra_data, train_y, opts, Out);