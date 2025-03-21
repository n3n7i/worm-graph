
using Plots;

function gtrace(mat1, init, steps)

  v1 = collect(1:size(mat1,1)) .== init;

  for i =1:steps

    v1 = vec(sum(mat1[v1.>0,:].>0,dims=1));

    print("active count:", sum(v1), "\n");

    end;

  return v1;

  end;


function gtrace_v(mat1, v1, steps)

  ##v1 = collect(1:size(mat1,1)) .== init;

  for i =1:steps

    v1 = vec(sum(mat1[v1.>0,:].>0,dims=1));

    print("active count:", sum(v1), "\n");

    end;

  return v1;

  end;



function gmat(mat1, ix, steps)

  r = zeros(size(mat1,1), steps);

  for i in 1:steps

    r[:,i] = gtrace(mat1, ix, i);

    end;

  return r;

  end;


function heat_anim(zn, xname)

  anim = @animate for j in 1:5:300
       ip3 = gmat(zm2, j, 3)
       ip4 = gmat(zmb, j, 3)
       v1 = collect(1:447).==j
       heatmap([ip4[:,end:-1:1] v1.*20 ip3])
       end;

  gif(anim, xname, fps=5);

  end;


function heat_graph(zn, dep)

  r0 = zeros(size(zn));

  for j in 1:300
       ip3 = gmat(zn, j, dep)
       #ip4 = gmat(zmb, j, 3)
       #v1 = collect(1:447).==j
       r0[j,:] = ip3[:,end];
       end;

  return r0;

  end;


function graph_adjacent(matA, matB)

  r0 = zeros(size(matA));

  for j in 1:300

    t1 = gtrace(matA, j, 1);

    t2 = gtrace_v(matB, t1, 1);

    r0[j, :] = t2;

    end;

  return r0;

  end;


