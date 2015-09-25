A = readtable('fuel-economy-dataset.csv');

%Create variable histograms
hist(A.displ);
print('displHistogram','-dpng');
hist(categorical(A.manufacturer));
print('manufacturerHistogram','-dpng');
hist(A.cty);
print('ctyHistogram','-dpng');
hist(A.hwy);
print('hwylHistogram','-dpng')
hist(categorical(A.model));
print('modelHistogram','-dpng')
hist(categorical(A.year));
print('yearHistogram','-dpng')
hist(categorical(A.trans));
print('transHistogram','-dpng')
hist(A.cyl);
print('cylHistogram','-dpng')
hist(categorical(A.drv));
print('drvHistogram','-dpng')
hist(categorical(A.class));
print('classHistogram','-dpng')
hist(categorical(A.fl));
print('flHistogram','-dpng')

%Remove attribute id
A.Var1 = [];

X = [A.cyl A.displ];
attributeNames = categorical(cellstr('cyl'));
attributeNames = [attributeNames 'dipl'];

%Convert Nominal variables to binary vectors
[X_tmp, attributeNames_tmp]=categoric2numeric(A.manufacturer);
X=[X X_tmp];
attributeNames=[attributeNames attributeNames_tmp];
[X_tmp, attributeNames_tmp]=categoric2numeric(A.model);
X=[X X_tmp];
attributeNames=[attributeNames attributeNames_tmp];
[X_tmp, attributeNames_tmp]=categoric2numeric(A.class);
X=[X X_tmp];
attributeNames=[attributeNames attributeNames_tmp];
[X_tmp, attributeNames_tmp]=categoric2numeric(A.drv);
X=[X X_tmp];
attributeNames=[attributeNames attributeNames_tmp];
[X_tmp, attributeNames_tmp]=categoric2numeric(A.fl);
X=[X X_tmp];
attributeNames=[attributeNames attributeNames_tmp];

%Convert year to binary
year = A.year;
year(year==2008) = 1;
year(year==1999) = 0;
X = [X year];
attributeNames = [attributeNames 'new'];

%Add the target variables
X = [X A.cty A.hwy];
attributeNames = [attributeNames 'cty' 'hwy'];

