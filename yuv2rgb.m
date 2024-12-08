function [RGB]= yuv2rgb(Y,U,V)
    R=Y+1.139834576*V;
    G=Y-.3946460533*U-.58060*V;
    B=Y+2.032111938*U;    

    RGB=cat(3,R,G,B); % cat(dim,A,B) concatenates B to the end of A along dimension dim when A and B have compatible sizes
end