

function match_vec(v1, v2)

  m1 = max(min(sum(v1), sum(v2)), 1);

  c1 = sum(v1 .* v2);

  return c1 / m1;

  end;



function match_mat(m1,m2, skip=false)

  m = size(m1,1);

  r = zeros(m,m);

  for i = 1:m

    for j = 1:m

      if skip & (i==j)

        continue; 
 
        end;

      r[i,j] = match_vec(m1[i, :], m2[j,:]);

      end;

    end;

  return r;

  end;

