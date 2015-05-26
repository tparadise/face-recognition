% Tom Paradise
% personIdentifier.m
% Randomize all image pictures and split into train and test datasets 
% Use the first 100 principal components to train a neural network to 
% recognize ONE particular person of your choice

clear all
close all

personIdentifierImageReader

% Y_train = .9 an2i and .1 for not an2i
Y_train = yRand;
X_train = xRand;
[M N]=size(X_train);
iv_train = X_train(:,1:round((N-2)*(9/10)));
% X_test = double(xtest);
iv_test = X_train(:,round((N-2)*(9/10)):end);
dv_train = yRand(:,1:round((N-2)*(9/10)));
% dv_test = Y_test';

X = X_train;
%Xt = X';

% PC
correlation_X = corrcoef(X);
N = length(X);
standardized_X = (X - repmat(mean(X),N,1) )./  repmat(std(X),N,1);
[pc_coeffs, X_pc, pc_variance] = princomp( standardized_X' );

[M N] = size(X_train);

net = feedforwardnet(3,'trainlm'); % 3 neurons
net.layers{1}.transferFcn = 'logsig';

net.divideFcn = 'dividerand';
net.divideParam.trainRatio = .75;
net.divideParam.valRatio = .25;
net.divideParam.testRatio =0;

% [net,tr] = train(net,iv_train,dv_train);
[net,tr] = train(net,X_pc(1:round((N-2)*(9/10)),1:100)',dv_train);

net.iw %Input Layer
net.lw %Hidden Layers
net.b %biases
view(net);
%Using the Neural Network
Y_hat = sim(net,X_pc(round((N-2)*(9/10)):end,1:100)');
Y_guess = round(Y_hat);
realY = round(yRand(:,round((N-2)*(9/10)):end));

matches = Y_guess == realY;
PerCorrect = sum(matches)/length(matches)*100
%%
index = find(realY);
num = sum(Y_guess(index));
den = sum(realY);
truePositive = (num/den)*100
