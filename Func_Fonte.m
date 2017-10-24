function  [R,G,B] = Func_Fonte(video, frameNumber)

    x = read(video, frameNumber);
    
    X = double(x);
    R=X(:,:,1);
    G=X(:,:,2);
    B=X(:,:,3);
end