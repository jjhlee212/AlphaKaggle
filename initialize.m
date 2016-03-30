function N = initialize(filename)

% Replacing zeros with the mean of the non-missing points for each feature

M = csvReadFromKaggle(filename);

[n1,n2] = size(M);

N = M;

count = 0;
summation = 0;
for j = 1:n2
    for i = 1:n1
        if(isnan(N(i,j)) == 0)
            count = count + 1;
            summation = summation + N(i,j);
        end
    end
    average = summation/count;
    for i = 1:n1
        if(isnan(M(i,j)) == 1)
            N(i,j) = 0;
        end
    end
    count = 0;
    summation = 0;
end