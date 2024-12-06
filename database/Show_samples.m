

function Img_sample=Show_samples(handles)

dataname=handles.database_name;

current_data=handles.current_data;

if (strcmp(dataname, 'MNIST'))
    
    temp_data=current_data.MINST.train_x;
    temp_label=current_data.MINST.train_y;
    
    [~,temp_ind]=max(temp_label, [ ], 2);
    
    patch_size=30;
    
    Img_sample=zeros(patch_size*10, patch_size*10)+255;
    
    for ii=1:10
        label_ind=find(temp_ind==ii);
        
        n_sample=numel(label_ind);
        
        rand_ind=randperm(n_sample);
        
        row_begin=1+(ii-1)*patch_size;
        
        for jj=1:10
            
            img_1=temp_data(label_ind(rand_ind(jj)), :);
            img_2=reshape(img_1, [28 28]);
            
            col_begin=1+(jj-1)*patch_size;
            
            
            Img_sample(row_begin: row_begin+27, col_begin:col_begin+27)=img_2';
            
        end
        
    end
    
    imshow(Img_sample/255);
    
end


if (strcmp(dataname, 'CIFAR10'))
    
     temp_data=current_data.CIFAR10.train_x;
    temp_label=current_data.CIFAR10.train_y;
    
    [~,temp_ind]=max(temp_label, [ ], 2);
    
    patch_size=35;
    
    Img_sample=zeros(patch_size*10, patch_size*10, 3)+255;
    
    for ii=1:10
        label_ind=find(temp_ind==ii);
        
        n_sample=numel(label_ind);
        
        rand_ind=randperm(n_sample);
        
        row_begin=1+(ii-1)*patch_size;
        
        for jj=1:10
            
            img_1=temp_data(label_ind(rand_ind(jj)), :);
            img_2=reshape(img_1, [32 32 3]);
            
            col_begin=1+(jj-1)*patch_size;
            
            Img_sample(row_begin: row_begin+31, col_begin:col_begin+31, 1)=img_2(:, :, 1)';
            Img_sample(row_begin: row_begin+31, col_begin:col_begin+31, 2)=img_2(:, :, 2)';
            Img_sample(row_begin: row_begin+31, col_begin:col_begin+31, 3)=img_2(:, :, 3)';
            
        end
        
    end
    
    imshow(Img_sample/255);
    
end

end