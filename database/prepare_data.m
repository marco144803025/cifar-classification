

clc;
clear all;

addpath('cifar-10');

train_data=[ ];
train_label=[ ];

test_data=[ ];
test_label=[ ];

for i=1:5
    load(strcat('cifar-10\', 'data_batch_', num2str(i)));
    
    train_data=[train_data; data];
    train_label=[train_label; labels];
    
end

load test_batch;

test_data=data;
test_label=labels;


n_train=size(train_data , 1);
n_test=size(test_data, 1);

train_y=zeros(n_train, 10);
test_y=zeros(n_test, 10);

for pp=1:n_train
    if (pp<=n_test)
        test_y(pp, test_label(pp)+1)=1;
    end
    
    train_y(pp, train_label(pp)+1)=1;
end

train_x=train_data;
test_x=test_data;

CIFAR10.train_x=train_x;
CIFAR10.test_x=test_x;
CIFAR10.train_y=train_y;
CIFAR10.test_y=test_y;

save CIFAR10 CIFAR10;