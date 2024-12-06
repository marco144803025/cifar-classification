

load MINST;
load CIFAR10;


train_label=CIFAR10.train_y;
test_label=CIFAR10.test_y;


[~, target_val]=max(test_label, [ ], 2);

n_sample=100;

temp_val=target_val(1:n_sample);

Count=zeros(1, 10);
for pp=1:10
    
    Count(pp)=numel(find(temp_val==pp));
    
end