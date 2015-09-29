A = readtable('fuel-economy-dataset.csv');

%Create variable histograms
hist(A.displ);
print('displHistogram','-depsc', '-tiff');
hist(categorical(A.manufacturer));
set(gca,'XTick',[]);
set(gca,'XTickLabel',[]);
print('manufacturerHistogram','-depsc', '-tiff');
hist(A.cty);
print('ctyHistogram','-depsc', '-tiff');
hist(A.hwy);
print('hwyHistogram','-depsc', '-tiff')
hist(categorical(A.model));
set(gca,'XTick',[]);
set(gca,'XTickLabel',[]);
print('modelHistogram','-depsc', '-tiff')
hist(categorical(A.year));
print('yearHistogram','-depsc', '-tiff')
hist(categorical(A.trans));
set(gca,'XTick',[]);
set(gca,'XTickLabel',[]);
print('transHistogram','-depsc', '-tiff')
hist(A.cyl);
print('cylHistogram','-depsc', '-tiff')
hist(categorical(A.drv));
print('drvHistogram','-depsc', '-tiff')
hist(categorical(A.class));
print('classHistogram','-depsc', '-tiff')
hist(categorical(A.fl));
print('flHistogram','-depsc', '-tiff')

Y = [A.cty A.hwy A.displ A.cyl A.year];
names = [cellstr('cty') cellstr('hwy') cellstr('dipls') cellstr('cyl') cellstr('year')];
Ycat = [categorical(A.trans) categorical(A.drv) categorical(A.fl) categorical(A.class) categorical(A.manufacturer)  categorical(A.model)];
namescat = [cellstr('trans'), cellstr('drv'), cellstr('fl'), cellstr('class'), cellstr('man'), cellstr('model')]; 
cols = size(Y, 2);
colscat = size(Ycat, 2);
figure;
hold on;
count = 1;
for i = 1:cols
    for j = 1:cols
        subplot(cols + colscat, cols + colscat, count);
        count = count +1;
        plot(Y(:,i), Y(:,j), '.');
        set(gca,'XTick',[]);
        set(gca,'XTickLabel',[]);
        set(gca,'YTick',[]);
        set(gca,'YTickLabel',[]);
        xlabel(names(i));
        ylabel(names(j));
    end
    for j = 1:colscat
        subplot(cols + colscat, cols + colscat, count);
        count = count +1;
        plot(Y(:,i), Ycat(:,j), '.');
        set(gca,'XTick',[]);
        set(gca,'XTickLabel',[]);
        set(gca,'YTick',[]);
        set(gca,'YTickLabel',[]);
        xlabel(names(i));
        ylabel(namescat(j));
    end 
end
for i = 1:colscat
    for j = 1:cols
        subplot(cols + colscat, cols + colscat, count);
        count = count +1;
        plot(Ycat(:,i), Y(:,j), '.');
        set(gca,'XTick',[]);
        set(gca,'XTickLabel',[]);
        set(gca,'YTick',[]);
        set(gca,'YTickLabel',[]);
        xlabel(namescat(i));
        ylabel(names(j));
    end
    for j = 1:colscat
        subplot(cols + colscat, cols + colscat, count);
        count = count +1;
        plot(Ycat(:,i), Ycat(:,j), '.');
        set(gca,'XTick',[]);
        set(gca,'XTickLabel',[]);
        set(gca,'YTick',[]);
        set(gca,'YTickLabel',[]);
        xlabel(namescat(i));
        ylabel(namescat(j));
    end
end
print('scatterplot','-depsc', '-tiff')
hold off;

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
% X = [X A.cty A.hwy];
% attributeNames = [attributeNames 'cty' 'hwy'];

% Subtract the mean from the data
Y = bsxfun(@minus, X, mean(X));

% Obtain the PCA solution by calculate the SVD of Y
[U, S, V] = svd(Y);

% Compute the projection onto the principal components
Z = U*S;

figure(1); clf;
plot(Z(:,1), A.cty, '*')
hold on;
plot(Z(:,1), A.hwy, 'o')
xlabel('PCA1');
ylabel('MPG');
legend('City MPG', 'Highway MPG');
legend('boxoff');
title('City and Highway MPG vs. PCA1');

figure(2); clf;
plot(Z(:,2), A.cty, '*')
hold on;
plot(Z(:,2), A.hwy, 'o')
xlabel('PCA2');
ylabel('MPG');
legend('City MPG', 'Highway MPG');
legend('boxoff');
title('City and Highway MPG vs. PCA2');

figure(3); clf;
plot(Z(:,3), A.cty, '*')
hold on;
plot(Z(:,3), A.hwy, 'o')
xlabel('PCA3');
ylabel('MPG');
legend('City MPG', 'Highway MPG');
legend('boxoff');
title('City and Highway MPG vs. PCA3');

figure(4); clf;
plot3(Z(:,1), Z(:,2), A.cty, 'x')
hold on;
plot3(Z(:,1), Z(:,2), A.hwy, 'o')
xlabel('PCA1');
ylabel('PCA2');
zlabel('MPG');
legend('City MPG', 'Highway MPG');
legend('boxoff');
title('PCA1 vs. PCA2');

% Compute variance explained
rho = diag(S).^2./sum(diag(S).^2);

% Plot variance explained
figure(5); clf;
plot(rho, 'o-');
xlabel('Principal Component Number');
ylabel('Percent of Variation Explained');
zlabel('PCA3');
title('Variance Explained by Principal Components');