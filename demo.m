% Demo for matrix completion
% Create a random matrix of low rank, remove values and complete.
%{
clc
A = randn(200,10)*randn(10,200); % 200x200 of rank 10
B = rand(size(A))<0.9; % remove 10% of the entries
%}

A = initialize('Mobserved50by200');
B = FindMissingValues('Mobserved50by200');
lamnbda_tol = 10;
tol = 1e-7;
N = 100;
%{
fprintf('Completion using nuclear norm minimization... \n');
[CompletedMat, ier] = MatrixCompletion(A, B,N, 'nuclear', lamnbda_tol, tol, 0);
%[CompletedMat, ier] = MatrixCompletion(A.*B, B,N, 'nuclear', lamnbda_tol, tol, 0);


fprintf('\n Corrupted matrix nuclear norm (initial): %g \n',sum(svd(A.*B)));
fprintf('Restored matrix nuclear norm (final): %g \n',sum(svd(CompletedMat)));
fprintf('MSE on known entries: %g \n',sqrt(sum2((CompletedMat-A).*B)/sum(B(:))));
%}
fprintf('\n Completion using spectral norm minimization... \n');
[CompletedMat, ier] = MatrixCompletion(A, B,N, 'spectral', lamnbda_tol, tol, 0);

%{
fprintf('\n Corrupted matrix spectral norm (initial): %g \n',norm(A.*B));
fprintf('Restored matrix spectral norm (final): %g \n',norm(CompletedMat));
fprintf('MSE on known entries: %g \n',sqrt(sum2((CompletedMat-A).*B)/sum(B(:))));

fprintf('\n Completion using weighted norm minimization (pushing to low rank, no global convergence)... \n');
[CompletedMat, ier] = MatrixCompletion(A.*B, B,N, 'NuclearWeighted', lamnbda_tol, tol, 0, [ones(1,10) ones(1,190)*10000] ); % big penalty on small singular values

fprintf('Corrupted matrix rank (initial): %g \n',rank(A.*B));
fprintf('Restored matrix rank (final): %g \n',rank(CompletedMat));
fprintf('MSE on known entries: %g \n \n',sqrt(sum2((CompletedMat-A).*B)/sum(B(:))));
%}
