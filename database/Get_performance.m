

function Res=Get_performance(predict_label, target_label, opts)

n_sample=numel(predict_label);

acc=numel(find(predict_label==target_label))/n_sample;

Res.acc=acc;

Con_Mat=Get_Con_Mat(target_label, predict_label, opts.class);

Res.Con_mat=Con_Mat;

end