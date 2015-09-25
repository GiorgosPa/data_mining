A = readtable('fuel-economy-dataset.csv');

%Remove attributes fl and id they do not look intresting in our goal
A.fl = [];
A.Var1 = [];

%Convert manufacturer to binary vector
manufacturer = A.manufacturer;
manufacturer_names = unique(manufacturer);
manufacturers = zeros(size(manufacturer, 1), size(manufacturer_names, 1));

for i = 1 : size(manufacturer, 1)
    for j=1 : size(manufacturer_names, 1)
        if size(manufacturer{i}) == size(manufacturer_names{j})
            if manufacturer{i} == manufacturer_names{j}
                manufacturers(i, j) = 1;
            end
        end
    end
end

A.manufacturer = manufacturers;

%Convert model to binary vector
model = A.model;
model_names = unique(model);
models = zeros(size(model, 1), size(model_names, 1));

for i = 1 : size(model, 1)
    for j=1 : size(model_names, 1)
        if size(model{i}) == size(model_names{j})
            if model{i} == model_names{j}
                models(i, j) = 1;
            end
        end
    end
end

A.model = models;

%Convert trans to binary vector
trans = A.trans;
trans_names = unique(trans);
transitions = zeros(size(trans, 1), size(trans_names, 1));

for i = 1 : size(trans, 1)
    for j=1 : size(trans_names, 1)
        if size(trans{i}) == size(trans_names{j})
            if trans{i} == trans_names{j}
                transitions(i, j) = 1;
            end
        end
    end
end

A.trans = transitions;

%Convert drv to binary vector
drv = A.drv;
drv_names = unique(drv);
drvs = zeros(size(drv, 1), size(drv_names, 1));

for i = 1 : size(drv, 1)
    for j=1 : size(drv_names, 1)
        if size(drv{i}) == size(drv_names{j})
            if drv{i} == drv_names{j}
                drvs(i, j) = 1;
            end
        end
    end
end

A.drv = drvs;

%Convert class to binary vector
class = A.class;
class_names = unique(class);
classes = zeros(size(class, 1), size(class_names, 1));

for i = 1 : size(class, 1)
    for j=1 : size(class_names, 1)
        if size(class{i}) == size(class_names{j})
            if class{i} == class_names{j}
                classes(i, j) = 1;
            end
        end
    end
end

A.class = classes;

%Convert year to binary
year = A.year;
year(year==2008) = 1;
year(year==1999) = 0;
A.year = [];
A.new = year;

%Remove the target variables
cty = A.cty;
hwy = A.hwy;
A.cty = [];
A.hwy = [];

M = table2array(A);

