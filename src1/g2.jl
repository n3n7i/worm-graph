

function side_matrix(mat1)

  mat1_r = mat1';

  up_adj = graph_adjacent(mat1_r, mat1);

  down_adj = graph_adjacent(mat1, mat1_r);
  
  return up_adj, down_adj;

  end;

