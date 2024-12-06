
function Out=Softmax_Classifier_1(train_x,  train_y, opts)

% setting learning parameters
step_size=opts.step_size;
reg=opts.reg;
batchsize = opts.batchsize;
numepochs = opts.numepochs;
K=opts.class;
h=opts.hidden_nodes;

% initialize the parameters
D=size(train_x, 2);
W1=0.01*randn(D,h);
b1=zeros(1,h);
W2=0.01*randn(h, K);
b2=zeros(1,K);

loss(1 : numepochs)=0;

num_examples=size(train_x, 1);
numbatches = num_examples / batchsize;

for epoch=1:numepochs
    
     kk = randperm(num_examples);
     loss(epoch)=0;
    
     for bat=1:numbatches
         
         batch_x = train_x(kk((bat - 1) * batchsize + 1 : bat * batchsize), :);
         batch_y = train_y(kk((bat - 1) * batchsize + 1 : bat * batchsize), :);
         
         %% compute the hidden layer
         f1=batch_x*W1+repmat(b1, batchsize, 1);
         y1=max(0, f1);
         
         %% compute the output layer
         f2=y1*W2+repmat(b2, batchsize, 1);
         y2=exp(f2);
         dd=repmat(sum(y2, 2), 1, K);
         probs=y2./dd;
         correct_logprobs=-log(sum(probs.*batch_y, 2));
         data_loss=sum(correct_logprobs)/batchsize;
         reg_loss=0.5*reg*sum(sum(W1.*W1))+0.5*reg*sum(sum(W2.*W2));
         loss(epoch) =loss(epoch)+ data_loss + reg_loss;
         
         df2 = probs-batch_y;
         df2=df2/batchsize;
         
         dy1=df2*W2';
         mask=max(sign(y1), 0);
         df1=dy1.*mask;
         
         dW2=y1'*df2;
         db2=sum(df2);
         
         dW1=batch_x'*df1;
         db1=sum(df1);
         
         dW2=dW2+reg*W2;
         dW1=dW1+reg*W1;
         
         W1=W1-step_size*dW1;
         b1=b1-step_size*db1;
         W2=W2-step_size*dW2;
         b2=b2-step_size*db2;
         
     end
     
     loss(epoch)=loss(epoch)/numbatches;
     
     sprintf('Epoch %d, train loss is %f, ', epoch, loss(epoch) )
     
end

Out.W1=W1;
Out.b1=b1;
Out.b2=b2;
Out.W2=W2;
Out.loss=loss;

