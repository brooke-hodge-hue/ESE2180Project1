function effectiveResistance = EffectiveResistance(i, j, resistanceFile, n)
    allResistances = readResistances(resistanceFile);
    r1s = allResistances(:,1);
    r2s = allResistances(:,2);
    out = allResistances(:,3);
    matrix = zeros(n,n);
    
    for k = 1:size(r1s)
        resistance = out(k);
        matrix(r1s(k), r1s(k)) = matrix(r1s(k), r1s(k)) + 1 / resistance;
        matrix(r2s(k), r2s(k)) = matrix(r2s(k), r2s(k)) + 1 / resistance;
        matrix(r1s(k), r2s(k)) = matrix(r1s(k), r2s(k)) - 1 / resistance;
        matrix(r2s(k), r1s(k)) = matrix(r2s(k), r1s(k)) - 1 / resistance;
    end

    elim = zeros(n,1);

    elim(i) = 1;
    elim(j) = -1;
    
    keep = true(n,1);
    keep(j) = false;
    newm1 = matrix(keep,keep);
    newm2 = elim(keep);

end