

using Random;

function activ_step(mat1, cnt = 25, thr = 0.5, n2=300)

  n = size(mat1,1);

  t1 = sum(mat1.>0,dims=1);

  init = randperm(n2)[1:cnt];

  init_v = [x in init for x=collect(1:n)];

  r1 = gtrace_v(mat1, init_v, 1);

  r2 = vec(r1) .>= vec(t1 .* thr);

  return init_v, r1, r2;

  end;



function activ_step_series(mat1, init_v, steps, thr = 0.5, fuzz=false, fp=0.5)

  n = size(mat1,1);

  r0 = zeros(steps+1, n);

  r0[1,:] = init_v;

  t1 = sum(mat1.>0,dims=1);

  ##init = randperm(n)[1:cnt];

  ##init_v = [x in init for x=collect(1:n)];

  for i = 2:steps+1

    r1 = gtrace_v(mat1, init_v, 1);

    r2 = vec(r1) .>= vec(t1 .* thr);

    r0[i, :] = r2;

    init_v = r2;# .+ (rand(n).>0.6) .- (rand(n).>0.6);

    if fuzz & (i%20==0)

      init_v = (rand(n).>fp);# .- (rand(n).>0.6);

      end;

    end;

  return r0;

  end;


function activ_step_series2(mat1, init_v, steps, thr = 0.5)

  n = size(mat1,1);

  r0 = zeros(steps+1, n);

  r0[1,:] = init_v;

  t1 = vec(sum(mat1.>0,dims=1));

  thr2 = vec(zeros(n)) .+ thr;

  r3 = zeros(steps+1, n);

  r3[1,:] = thr2;


  ##init = randperm(n)[1:cnt];

  ##init_v = [x in init for x=collect(1:n)];

  for i = 2:steps+1

    r1 = gtrace_v(mat1, init_v, 1);

    r2 = vec(r1) .>= vec(t1 .* thr2);

    r0[i, :] = r2;

    #t1 = min.(t1 .+ vec((r2 .- (r2.==0)./4)).*0.1, 4);

    thr2 = max.(thr2 .+ vec((r2 .- (r2.==0)./2)).*0.1, thr/2);

    init_v = r2;

    r3[i, :] = thr2;

    end;

  return r0, r3;

  end;

