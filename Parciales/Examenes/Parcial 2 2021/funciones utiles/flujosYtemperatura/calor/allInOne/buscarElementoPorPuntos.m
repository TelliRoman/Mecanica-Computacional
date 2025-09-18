function elem = buscarElementoPorPuntos(p,xnode)
    elem = [];
    dist = cellfun(@norm,num2cell(xnode-p,2));
    for i = 1:3
        [~,idx] = min(dist);
        elem = [elem idx];
        dist(idx) = 100000000;
    end 
end
