

using CSV, DataFrames;

r1 = CSV.read("./herm_full_edgelist.csv", DataFrame);

m1 = Matrix(r1);

s1 = strip.(r1[!, :Source]);

t1 = strip.(r1[!, :Target]);

us1 = unique(s1);

ut1 = unique(t1);

n = size(ut1,1);

m = size(m1,1);

for i=1:n

  if !(ut1[i] in us1)
    print(ut1[i], "\n");
    end;

  end;

zm = zeros(Int16, size(us1,1), n);

for i=1:m

  local sid1 = indexin([s1[i]], us1)[1];

  local tid1 = indexin([t1[i]], ut1)[1];

  local v1 = m1[i,3];

  if (m1[i, 4] == "electrical")

    zm[sid1, tid1] = v1;

    end;

  end;

print("sparsematrix \n");

act1 = rand(size(zm, 1), 1);

perm1 = indexin(us1, ut1)

act2 = (act1' * zm)[perm1];


