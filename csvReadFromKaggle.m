% Reads a csv file made for the matrix completion project on Kaggle
% Returns a matrix, M.  Entries that are unknown are denoted NaN.


function M = csvReadFromKaggle(filename)
    T = readtable([filename, '.csv']);
    %'moo'
    n1 = -1*T{1,1};
    n2 = T{1,2};
    Mknown = T{2:end, 2};
    IndexValues = T{2:end, 1};
    
    M = zeros(n1, n2);
    for i = 1:n1
        for j = 1:n2
            M(i,j) = nan;
        end
    end
   
    for i = 1:length(IndexValues)
        index = IndexValues(i);
        row = mod(index -1, n1) + 1;
        col = (index - row)/n1 + 1;
        [index, row, col];
        M(row, col) = Mknown(i);
    end
    

    M = reshape(M, n1, n2);

end

