
%%%  Get confusion matrix

function Con_Mat=Get_Con_Mat(test_label, predict_label, class_num)

Con_Mat=zeros(class_num,  class_num);

for class_id=1:length(test_label)
    con_row=test_label(class_id);
    con_col=predict_label(class_id);   
    Con_Mat(con_row, con_col)=Con_Mat(con_row, con_col)+1;
end

for ii=1:class_num
    Con_Mat(ii, :)=Con_Mat(ii, :)/sum(Con_Mat(ii, :), 2);
end

