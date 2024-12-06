

%% MLP classifier

function Out= MLP_Classifier(train_x, train_y, opts) 

% setting learning parameters
step_size=opts.step_size;
reg=opts.reg;
batchsize = opts.batchsize;
numepochs = opts.numepochs;
K=opts.class;

% initialize the parameters
D=size(train_x, 2);
W=0.01*randn(D,K);
b=zeros(1,K);

Error(1:numepochs)=0;

num_examples=size(train_x, 1);
numbatches = num_examples / batchsize;

for epoch=1:numepochs
    
        kk = randperm(num_examples);
        Error(epoch)=0;
        
    for bat=1:numbatches
        
         batch_x = train_x(kk((bat - 1) * batchsize + 1 : bat * batchsize), :);
         batch_y = train_y(kk((bat - 1) * batchsize + 1 : bat * batchsize), :);
        
        cc=repmat(b,  batchsize  , 1);
        f=batch_x*W+cc;
        y=1./(1+exp(-f));
        
        data_loss=0.5*sum(sum((y-batch_y).^2))/batchsize;
        reg_loss=0.5*reg*sum(sum(W.*W));
        Error(epoch) =Error(epoch)+ data_loss + reg_loss;
        
        df=(y-batch_y).*y.*(1-y)/batchsize;
        
        dW=batch_x'*df;
        db=sum(df);
        
        dW=dW+reg*W;
        
        W=W-step_size*dW;
        b=b-step_size*db;
    
    end
    
    Error(epoch)=Error(epoch)/numbatches;
    
    sprintf('Epoch %d, train loss is %f, ', epoch, Error(epoch) )
    
    
end

Out.W=W;
Out.b=b;
Out.loss=Error;
