%% Softmax classifier

function  Out=Softmax_Classifier(train_x,  train_y, opts)


% setting learning parameters
step_size=opts.step_size;
reg=opts.reg;
batchsize = opts.batchsize;
numepochs = opts.numepochs;
K=opts.class;

%% learn on the training set

% initialize the parameters
D=size(train_x, 2);
W=0.01*randn(D,K);
b=zeros(1,K);

loss(1 : numepochs)=0;

num_examples=size(train_x, 1);
numbatches = num_examples / batchsize;

for epoch=1:numepochs
    
        kk = randperm(num_examples);
        loss(epoch)=0;
        
    for bat=1:numbatches
        
         batch_x = train_x(kk((bat - 1) * batchsize + 1 : bat * batchsize), :);
         batch_y = train_y(kk((bat - 1) * batchsize + 1 : bat * batchsize), :);
        
        cc=repmat(b,  batchsize  , 1);
        scores=batch_x*W+cc;
        exp_scores=exp(scores);
        dd=repmat(sum(exp_scores, 2), 1, K);
        probs=exp_scores./dd;
        correct_logprobs=-log(sum(probs.*batch_y, 2));
        data_loss=sum(correct_logprobs)/batchsize;
        reg_loss=0.5*reg*sum(sum(W.*W));
        loss(epoch) =loss(epoch)+ data_loss + reg_loss;
        
        dscores = probs-batch_y;
        dscores=dscores/batchsize;
        
        dW=batch_x'*dscores;
        db=sum(dscores);
        
        dW=dW+reg*W;
        
        W=W-step_size*dW;
        b=b-step_size*db;
    
    end
    
    loss(epoch)=loss(epoch)/numbatches;
    
    sprintf('Epoch %d, train loss is %f, ', epoch, loss(epoch) )
 
end

Out.W=W;
Out.b=b;
Out.loss=loss;

end
