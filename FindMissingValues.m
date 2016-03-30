function B = FindMissingValues(filename)
A = csvReadFromKaggle(filename);
[a1,a2] = size(A);
for i = 1:a1
    for j = 1:a2
        if(isnan(A(i,j)) == 1)
            A(i,j) = 0;
        else
            A(i,j) = 1;
        end
    end
end
B = A;
end