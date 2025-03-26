

xstaticA = """

<html>
<body>
<canvas id='c1' width=800 height=800></canvas>

<script>

const canvas = document.getElementById("c1");
const ctx = canvas.getContext("2d");

ctx.strokeStyle = "#0003";

//ctx.beginPath();

//ctx.moveTo(20, 20);
//ctx.lineTo(20, 100);
//ctx.lineTo(70, 100);
//ctx.stroke();

""";


xstaticB = """

//ctx.stroke();

</script>
</body>
</html>

 """;


function sparsetoCon(mat1)

  n = size(mat1,1);

  m = size(mat1,1);

  r1 = [];

  r2 = [];

  for i = 1:n

    for j = 1:m

      if mat1[i,j] > 0

        push!(r1, i);

        push!(r2, j);

        end;

      end;

    end;

  return r1, r2;

  end;





function toGraph(p1, p2, mat1, s=50)

  n = size(p1,1);

  ##m = round.(rand(n,2) .* 600);

  m = nodeShift(mat1, s);

  xstr3 = "";

  for i=1:n

    tx = m[p1[i], 1];
    ty = m[p1[i], 2];
    tx2 = m[p2[i], 1];
    ty2 = m[p2[i], 2];

    xstr = "ctx.moveTo(" * string(tx) * "," * string(ty) * ");\n";
    xstr2 = "ctx.lineTo(" * string(tx2) * "," * string(ty2) * ");\n";

    xstr3 = xstr3 * "ctx.beginPath();\n" * xstr * xstr2 * "ctx.stroke();\n ctx.closePath();\n";

    end;

  ##xstr3 = xstr3 * "ctx.stroke();";

  return xstaticA * xstr3 * xstaticB;

  end;


function fileout(fname, xstr)

  f1 = open(fname, "w");

  write(f1, xstr);

  close(f1);

  end;


function nodeShift(mat1, s=50)

  n = size(mat1,1);

  m = round.(rand(n,2) .* 600).+100;

  m1 = mean(m, dims=1);

  mat2 = (mat1 .+ mat1') .>0;

  x1 = vec(sum(mat2, dims=2));

  for i = 1:s

    print("iter ", i, "\n");

    m1 = mean(m, dims=1);

    for j = 1:n

     if x1[j]>1

        m[j,:] = m[j,:] .+ (mean(m[mat2[j,:].>0,:], dims=1)' .- m[j,:]) .* 0.02 .+ (m1' .- m[j,:]) .* -0.03 .+ 
                 (mean(m[mat2[j,:].==0,:], dims=1)' .- m[j,:]) .* -0.01;

        end;

      end;

    end;

  mr = 600 ./ (maximum(m,dims=1) .- minimum(m,dims=1));

  ms = minimum(m,dims=1);

  m = (m .- ms) .* mr;

  return round.(m);

  end;


